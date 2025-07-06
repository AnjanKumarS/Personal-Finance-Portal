from flask import Blueprint, render_template, redirect, url_for, flash, request, abort
from flask_login import login_required, current_user
from app.models.user import User
from app import db
from functools import wraps

admin_bp = Blueprint('admin', __name__, url_prefix='/admin')

def admin_required(f):
    """Decorator to require admin access"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not current_user.is_authenticated or not current_user.is_admin:
            abort(403)  # Forbidden
        return f(*args, **kwargs)
    return decorated_function

@admin_bp.route('/')
@login_required
@admin_required
def index():
    """Admin dashboard"""
    total_users = User.query.count()
    active_users = User.query.filter_by(is_active=True).count()
    pending_users = User.query.filter_by(is_active=False).count()
    
    return render_template('admin/index.html',
                         total_users=total_users,
                         active_users=active_users,
                         pending_users=pending_users)

@admin_bp.route('/pending-requests')
@login_required
@admin_required
def pending_requests():
    """Show pending user approval requests"""
    pending_users = User.query.filter_by(is_active=False).order_by(User.created_at.desc()).all()
    return render_template('admin/pending_requests.html', pending_users=pending_users)

@admin_bp.route('/users')
@login_required
@admin_required
def users():
    """Show all users with pagination"""
    page = request.args.get('page', 1, type=int)
    users = User.query.order_by(User.created_at.desc()).paginate(
        page=page, per_page=20, error_out=False)
    return render_template('admin/users.html', users=users)

@admin_bp.route('/approve-user/<int:user_id>', methods=['POST'])
@login_required
@admin_required
def approve_user(user_id):
    """Approve a user account"""
    user = User.query.get_or_404(user_id)
    if user.is_active:
        flash('User is already approved', 'info')
    else:
        user.approve(current_user)
        db.session.commit()
        flash(f'User {user.username} has been approved', 'success')
    
    # Redirect back to the page they came from
    referrer = request.referrer or url_for('admin.index')
    return redirect(referrer)

@admin_bp.route('/reject-user/<int:user_id>', methods=['POST'])
@login_required
@admin_required
def reject_user(user_id):
    """Reject a user account"""
    user = User.query.get_or_404(user_id)
    if user.is_admin:
        flash('Cannot reject admin users', 'danger')
    else:
        username = user.username
        db.session.delete(user)
        db.session.commit()
        flash(f'User {username} has been rejected and deleted', 'success')
    
    # Redirect back to the page they came from
    referrer = request.referrer or url_for('admin.index')
    return redirect(referrer)

@admin_bp.route('/toggle-admin/<int:user_id>', methods=['POST'])
@login_required
@admin_required
def toggle_admin(user_id):
    """Toggle admin status for a user"""
    user = User.query.get_or_404(user_id)
    if user.id == current_user.id:
        flash('You cannot modify your own admin status', 'danger')
    else:
        user.toggle_admin()
        db.session.commit()
        status = 'admin' if user.is_admin else 'regular user'
        flash(f'User {user.username} is now a {status}', 'success')
    
    # Redirect back to the page they came from
    referrer = request.referrer or url_for('admin.index')
    return redirect(referrer)

@admin_bp.route('/delete-user/<int:user_id>', methods=['POST'])
@login_required
@admin_required
def delete_user(user_id):
    """Delete a user account"""
    user = User.query.get_or_404(user_id)
    if user.id == current_user.id:
        flash('You cannot delete your own account', 'danger')
    else:
        username = user.username
        db.session.delete(user)
        db.session.commit()
        flash(f'User {username} has been deleted', 'success')
    
    # Redirect back to the page they came from
    referrer = request.referrer or url_for('admin.index')
    return redirect(referrer) 