#!/usr/bin/env python3
"""
Database initialization script for Personal Finance Portal
Run this script to initialize the database and create admin user
"""

from app import create_app, db
from app.models.user import User
from app.models.expense import Expense
from app.models.budget import Budget
from app.models.investment import Investment
from app.models.bill import Bill
from werkzeug.security import generate_password_hash

def init_database():
    """Initialize the database with tables and admin user"""
    app = create_app()
    
    with app.app_context():
        print("Creating database tables...")
        
        # Create all tables
        db.create_all()
        
        print("Database tables created successfully!")
        
        # Check if admin user exists
        admin = User.query.filter_by(email='admin@financeportal.com').first()
        if not admin:
            print("Creating admin user...")
            admin_user = User(
                username='admin',
                email='admin@financeportal.com',
                password_hash=generate_password_hash('admin123'),
                is_admin=True,
                is_active=True
            )
            db.session.add(admin_user)
            db.session.commit()
            print("Admin user created successfully!")
            print("Email: admin@financeportal.com")
            print("Password: admin123")
        else:
            print("Admin user already exists")
        
        print("Database initialization completed!")

if __name__ == '__main__':
    init_database() 