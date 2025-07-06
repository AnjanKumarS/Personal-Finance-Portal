from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_user, logout_user, current_user, login_required
from app.models.user import User
from app import db
from app.utils.auth_utils import validate_password

auth_bp = Blueprint('auth', __name__, url_prefix='/auth')

@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    """Handle user login"""
    if current_user.is_authenticated:
        return redirect(url_for('dashboard.index'))
    
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')
        remember = 'remember' in request.form
        
        user = User.query.filter_by(email=email).first()
        if user and user.check_password(password):
            # Check if user is approved (unless they're an admin)
            if not user.is_active and not user.is_admin:
                flash('Your account is pending approval. Please contact an administrator.', 'warning')
                return render_template('auth/login.html', title='Login')
            
            login_user(user, remember=remember)
            next_page = request.args.get('next')
            return redirect(next_page or url_for('dashboard.index'))
        else:
            flash('Invalid email or password', 'danger')
    
    return render_template('auth/login.html', title='Login')

@auth_bp.route('/logout')
def logout():
    """Handle user logout"""
    logout_user()
    return redirect(url_for('auth.login'))

@auth_bp.route('/register', methods=['GET', 'POST'])
def register():
    """Handle user registration"""
    if current_user.is_authenticated:
        return redirect(url_for('dashboard.index'))
    
    if request.method == 'POST':
        email = request.form.get('email')
        username = request.form.get('username')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')
        
        # Check if user already exists
        user_exists = User.query.filter_by(email=email).first()
        if user_exists:
            flash('Email already registered', 'danger')
            return render_template('auth/register.html', title='Register')
        
        # Validate password
        if password != confirm_password:
            flash('Passwords do not match', 'danger')
            return render_template('auth/register.html', title='Register')
        
        if not validate_password(password):
            flash('Password must be at least 8 characters long and contain letters and numbers', 'danger')
            return render_template('auth/register.html', title='Register')
        
        # Create new user
        new_user = User(email=email, username=username)
        new_user.set_password(password)
        
        # Check if this is the first user (make them admin and auto-approve)
        total_users = User.query.count()
        if total_users == 0:
            new_user.is_admin = True
            new_user.is_active = True
            flash('Registration successful! You are the first user and have been made an administrator.', 'success')
        else:
            flash('Registration successful! Your account is pending approval by an administrator.', 'success')
        
        db.session.add(new_user)
        db.session.commit()
        
        return redirect(url_for('auth.login'))
    
    return render_template('auth/register.html', title='Register')
