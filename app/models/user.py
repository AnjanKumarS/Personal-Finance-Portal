from datetime import datetime
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
from app import db, login_manager

class User(db.Model, UserMixin):
    """User model for authentication and profile information"""
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), index=True, unique=True)
    email = db.Column(db.String(120), index=True, unique=True)
    password_hash = db.Column(db.String(128))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Admin and approval fields
    is_admin = db.Column(db.Boolean, default=False)
    is_active = db.Column(db.Boolean, default=False)  # Users need admin approval
    approved_at = db.Column(db.DateTime, nullable=True)
    approved_by = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=True)
    
    # Relationships
    expenses = db.relationship('Expense', backref='user', lazy='dynamic')
    budgets = db.relationship('Budget', backref='user', lazy='dynamic')
    investments = db.relationship('Investment', backref='user', lazy='dynamic')
    bills = db.relationship('Bill', backref='user', lazy='dynamic')
    
    def __repr__(self):
        return f'<User {self.username}>'
    
    def set_password(self, password):
        """Set password hash"""
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        """Check password against hash"""
        return check_password_hash(self.password_hash, password)
    
    def approve(self, approved_by_user):
        """Approve user account"""
        self.is_active = True
        self.approved_at = datetime.utcnow()
        self.approved_by = approved_by_user.id
    
    def reject(self):
        """Reject user account"""
        self.is_active = False
        self.approved_at = None
        self.approved_by = None
    
    def toggle_admin(self):
        """Toggle admin status"""
        self.is_admin = not self.is_admin

@login_manager.user_loader
def load_user(id):
    """Flask-Login user loader function"""
    return User.query.get(int(id))
