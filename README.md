# 💰 Personal Financial Portal

A modern, feature-rich personal finance management application built with Flask, featuring stunning video backgrounds, admin controls, and comprehensive financial tracking capabilities.

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![Flask](https://img.shields.io/badge/Flask-2.2+-green.svg)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-2.0+-orange.svg)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3+-purple.svg)

## 🌟 Features

### 🎥 **Stunning Visual Design**
- **Video Backgrounds** on authentication pages and dashboard
- **Dynamic Background Images** for each section
- **Glass-morphism UI** with backdrop blur effects
- **Responsive Design** optimized for all devices
- **Smooth Animations** and hover effects

### 👥 **User Management & Admin Portal**
- **User Registration & Login** with approval system
- **Admin Dashboard** with comprehensive user management
- **User Approval System** - admins can approve/reject new users
- **Role Management** - toggle admin privileges
- **User Statistics** - total users, active users, pending approvals

### 💳 **Financial Management**
- **Expense Tracking** with categories and descriptions
- **Budget Management** with spending limits and tracking
- **Investment Portfolio** management
- **Bill Management** with due dates and recurring payments
- **Financial Dashboard** with charts and analytics

### 📊 **Analytics & Reporting**
- **Interactive Charts** using Chart.js
- **Expense Breakdown** by category
- **Budget vs Actual** spending comparison
- **Recent Transactions** overview
- **Upcoming Bills** tracking

### 🔐 **Security Features**
- **Password Hashing** with Werkzeug
- **Session Management** with Flask-Login
- **Admin-only Access** to sensitive features
- **CSRF Protection** with Flask-WTF

### 🚀 **CI/CD Pipeline**
- **Automated Deployment** with Jenkins
- **6-Stage Pipeline** for complete automation
- **Kubernetes Integration** for scalable deployment
- **Docker Containerization** for consistent environments
- **Rollback Capability** for quick recovery

## 🚀 Quick Start

### Prerequisites
- Python 3.8 or higher
- pip (Python package installer)
- Docker (optional, for containerized deployment)
- kubectl (optional, for Kubernetes deployment)
- Jenkins (optional, for CI/CD pipeline)

### Option 1: Kubernetes Deployment (Production Ready)

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/Personal-Financial-Portal.git
   cd Personal-Financial-Portal
   ```

2. **Build Docker image**
   ```bash
   docker build -t finance-portal:latest .
   ```

3. **Deploy to Kubernetes**
   ```bash
   # Linux/macOS
   chmod +x k8s/deploy.sh
   ./k8s/deploy.sh
   
   # Windows
   k8s\deploy.bat
   ```

4. **Access the application**
   ```bash
   kubectl port-forward service/finance-portal-service 3000:80 -n finance-portal
   ```
   Then open http://localhost:3000 in your browser.

### Option 2: Docker Deployment (Development)

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/Personal-Financial-Portal.git
   cd Personal-Financial-Portal
   ```

2. **Run with Docker Compose**
   ```bash
   # On Windows
   run-docker.bat
   
   # On macOS/Linux
   chmod +x run-docker.sh
   ./run-docker.sh
   
   # Or manually
   docker-compose up --build
   ```

3. **Access the application**
   - Open your browser and go to `http://localhost:5000`
   - Admin credentials: `admin@financeportal.com` / `admin123`
   - Start managing your finances!

### Option 3: Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/Personal-Financial-Portal.git
   cd Personal-Financial-Portal
   ```

2. **Create a virtual environment**
   ```bash
   python -m venv env
   ```

3. **Activate the virtual environment**
   ```bash
   # On Windows
   env\Scripts\activate
   
   # On macOS/Linux
   source env/bin/activate
   ```

4. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

5. **Initialize the database**
   ```bash
   python -m flask db init
   python -m flask db migrate -m "Initial migration"
   python -m flask db upgrade
   ```

6. **Run the application**
   ```bash
   python run.py
   ```

7. **Access the application**
   - Open your browser and go to `http://localhost:5000`
   - Register as the first user (automatically becomes admin)
   - Start managing your finances!

### Option 4: CI/CD Pipeline with Jenkins

The project includes a comprehensive Jenkins CI/CD pipeline that automates the entire deployment process.

#### Pipeline Stages

The Jenkins pipeline consists of **6 automated stages**:

1. **🔗 Clone Repository**
   - Automatically clones the latest code from the main branch
   - Ensures the pipeline works with the most recent changes

2. **🏗️ Build Docker Image**
   - Builds the application Docker image with tag `finance-portal:latest`
   - Uses the Dockerfile in the project root

3. **📦 Push to Local Docker (Optional)**
   - Currently configured for local Docker usage
   - Can be extended to push to Docker Hub or other registries

4. **🚀 Deploy to Kubernetes**
   - Applies all Kubernetes manifests in the `k8s/` directory:
     - `namespace.yaml` - Creates the finance-portal namespace
     - `configmap.yaml` - Application configuration
     - `secret.yaml` - Sensitive data (passwords, keys)
     - `persistent-volume.yaml` - Storage configuration
     - `persistent-volume-claim.yaml` - Storage requests
     - `deployment.yaml` - Application deployment
     - `service.yaml` - Network service
     - `ingress.yaml` - External access configuration

5. **✅ Check Pod Status**
   - Verifies that all pods are running successfully
   - Provides deployment status feedback

#### Setup Jenkins Pipeline

1. **Install Jenkins**
   ```bash
   # On Ubuntu/Debian
   sudo apt update
   sudo apt install jenkins
   
   # On CentOS/RHEL
   sudo yum install jenkins
   
   # On Windows
   # Download from https://jenkins.io/download/
   ```

2. **Install Required Plugins**
   - Docker Pipeline
   - Kubernetes CLI
   - Git Integration

3. **Configure Jenkins**
   - Set up Docker credentials
   - Configure kubectl access
   - Set up webhook for automatic triggers

4. **Create Pipeline Job**
   - Create a new Pipeline job in Jenkins
   - Point to the Jenkinsfile in the repository
   - Configure webhook for automatic builds on code changes

#### Pipeline Configuration

The pipeline uses the following environment variables:
```groovy
environment {
    IMAGE_NAME = "finance-portal:latest"
}
```

#### Automated Triggers

- **Push to main branch** - Automatically triggers the pipeline
- **Pull Request** - Can be configured to run tests before merge
- **Manual trigger** - Available for on-demand deployments

#### Monitoring

- **Build History** - Track all pipeline runs
- **Console Output** - Detailed logs for each stage
- **Deployment Status** - Real-time pod status monitoring
- **Rollback Capability** - Quick rollback to previous versions

#### Benefits

- **Automated Deployment** - No manual intervention required
- **Consistent Environment** - Same deployment process every time
- **Quick Rollbacks** - Easy to revert to previous versions
- **Audit Trail** - Complete history of all deployments
- **Scalability** - Easy to scale up or down based on demand

## 📁 Project Structure

```
Personal-Financial-Portal/
├── app/
│   ├── __init__.py              # Flask app initialization
│   ├── config.py               # Configuration settings
│   ├── models/                 # Database models
│   │   ├── user.py            # User model with admin features
│   │   ├── expense.py         # Expense tracking
│   │   ├── budget.py          # Budget management
│   │   ├── investment.py      # Investment portfolio
│   │   └── bill.py            # Bill management
│   ├── routes/                # Application routes
│   │   ├── auth.py           # Authentication routes
│   │   ├── admin.py          # Admin portal routes
│   │   ├── dashboard.py      # Dashboard routes
│   │   ├── expenses.py       # Expense management
│   │   ├── budgets.py        # Budget management
│   │   ├── investments.py    # Investment management
│   │   ├── bills.py          # Bill management
│   │   ├── profile.py        # User profile
│   │   └── main.py           # Main routes
│   ├── static/               # Static files
│   │   ├── css/
│   │   │   └── style.css     # Custom styles with backgrounds
│   │   ├── js/
│   │   │   └── main.js       # JavaScript functionality
│   │   ├── images/           # Background images
│   │   └── videos/           # Background videos
│   ├── templates/            # HTML templates
│   │   ├── base.html         # Base template
│   │   ├── auth/             # Authentication templates
│   │   ├── admin/            # Admin portal templates
│   │   ├── dashboard/        # Dashboard templates
│   │   ├── expenses/         # Expense templates
│   │   ├── budgets/          # Budget templates
│   │   ├── investments/      # Investment templates
│   │   ├── bills/            # Bill templates
│   │   └── profile/          # Profile templates
│   └── utils/                # Utility functions
├── k8s/                     # Kubernetes deployment files
│   ├── namespace.yaml        # Kubernetes namespace
│   ├── configmap.yaml        # Application configuration
│   ├── secret.yaml           # Sensitive data
│   ├── persistent-volume.yaml # Storage configuration
│   ├── persistent-volume-claim.yaml # Storage requests
│   ├── deployment.yaml       # Application deployment
│   ├── service.yaml          # Network service
│   ├── ingress.yaml          # External access
│   ├── deploy.sh             # Deployment script (Linux/macOS)
│   ├── deploy.bat            # Deployment script (Windows)
│   └── cleanup.sh            # Cleanup script
├── migrations/               # Database migrations
├── instance/                 # Instance-specific files
├── requirements.txt          # Python dependencies
├── run.py                   # Application entry point
├── Dockerfile               # Docker container configuration
├── docker-compose.yml       # Docker Compose configuration
├── Jenkinsfile              # CI/CD pipeline configuration
└── README.md               # This file
```

## 🎨 Visual Features

### Background Videos
- **Login Page**: `video_preview_h264.mp4` with blue gradient theme
- **Register Page**: `video_preview_h264 (1).mp4` with pink gradient theme
- **Dashboard**: `video_preview_h264123.mp4` with dynamic overlay

### Background Images
- **Dashboard**: `wp2446263.webp` - High-quality financial theme
- **Expenses**: `HD-wallpaper-finance-icons-blue-finance-background-currency-icons-money-background-currency-concepts-blue-money-backgroun.jpg` - Currency theme
- **Budgets**: `strategic-planning-illustration-download-in-svg-png-gif-file-formats--corporate-gathering-professional-conclave-company-.webp` - Planning theme
- **Investments**: `digital_currencies.jpg` - Digital currency theme
- **Bills**: `wp9223603.webp` - Modern finance theme

## 👨‍💼 Admin Features

### Admin Dashboard
- **User Statistics**: Total users, active users, pending approvals
- **Quick Actions**: Review pending requests, manage users
- **Real-time Updates**: Live data from database

### User Management
- **Approve/Reject Users**: Control user access
- **Toggle Admin Status**: Grant/revoke admin privileges
- **Delete Users**: Remove user accounts
- **User Details**: View registration dates, approval status

### Pending Requests
- **Review New Registrations**: See users awaiting approval
- **Bulk Actions**: Approve or reject multiple users
- **User Information**: Email, username, registration date

## 💰 Financial Features

### Expense Management
- **Add Expenses**: Amount, category, description, date
- **Categorize Expenses**: Food, Transport, Entertainment, etc.
- **Track Receipts**: Upload and store receipt images
- **Expense History**: View all past expenses

### Budget Management
- **Set Budgets**: Monthly/quarterly/yearly budgets by category
- **Track Spending**: Real-time spending vs budget
- **Budget Alerts**: Visual indicators for overspending
- **Budget Reports**: Detailed spending analysis

### Investment Portfolio
- **Add Investments**: Stocks, bonds, mutual funds, crypto
- **Track Performance**: Current value vs purchase price
- **Gain/Loss Tracking**: Calculate returns
- **Portfolio Overview**: Total invested and current value

### Bill Management
- **Add Bills**: Name, amount, due date, category
- **Recurring Bills**: Set up automatic bill tracking
- **Payment Status**: Track paid, upcoming, overdue bills
- **Bill Reminders**: Never miss a payment

## 🔧 Troubleshooting

### Docker Issues

**Problem**: "no such table: user" error
- **Solution**: The database needs to be initialized. Run:
  ```bash
  docker-compose down
  docker-compose up --build
  ```

**Problem**: Container won't start
- **Solution**: Check if port 5000 is available. If not, change the port in `docker-compose.yml`:
  ```yaml
  ports:
    - "5001:5000"  # Use port 5001 instead
  ```

**Problem**: Database not persisting
- **Solution**: Ensure the volume mount is working. Check that `./instance:/app/instance` is properly mounted.

### Local Development Issues

**Problem**: Database migration errors
- **Solution**: Delete the `migrations` folder and `instance/finance_portal.db`, then run:
  ```bash
   flask db init
   flask db migrate -m "Initial migration"
   flask db upgrade
   ```

**Problem**: Import errors
- **Solution**: Ensure you're in the virtual environment and all dependencies are installed:
  ```bash
  pip install -r requirements.txt
  ```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:

```env
FLASK_APP=run.py
FLASK_ENV=development
SECRET_KEY=your-secret-key-here
DATABASE_URL=sqlite:///finance_portal.db
```

### Database Configuration
The application uses SQLite by default. For production, you can configure other databases:

```python
# PostgreSQL
DATABASE_URL=postgresql://username:password@localhost/dbname

# MySQL
DATABASE_URL=mysql://username:password@localhost/dbname
```

## 🚀 Deployment

### Local Development
```bash
   python run.py
   ```

### Production Deployment
1. **Set environment variables**
   ```bash
   export FLASK_ENV=production
   export SECRET_KEY=your-production-secret-key
   ```

2. **Use a production WSGI server**
   ```bash
   pip install gunicorn
   gunicorn -w 4 -b 0.0.0.0:5000 run:app
   ```

3. **Set up a reverse proxy** (Nginx/Apache) for better performance

## 📊 API Endpoints

### Authentication
- `GET /auth/login` - Login page
- `POST /auth/login` - Login form submission
- `GET /auth/register` - Registration page
- `POST /auth/register` - Registration form submission
- `GET /auth/logout` - Logout

### Admin Portal
- `GET /admin/` - Admin dashboard
- `GET /admin/pending-requests` - Pending user approvals
- `GET /admin/users` - User management
- `POST /admin/approve-user/<id>` - Approve user
- `POST /admin/reject-user/<id>` - Reject user
- `POST /admin/toggle-admin/<id>` - Toggle admin status
- `POST /admin/delete-user/<id>` - Delete user

### Financial Management
- `GET /dashboard` - Main dashboard
- `GET /expenses` - Expense management
- `GET /budgets` - Budget management
- `GET /investments` - Investment portfolio
- `GET /bills` - Bill management

## 🛠️ Technologies Used

- **Backend**: Flask, SQLAlchemy, Flask-Login, Flask-Migrate
- **Frontend**: Bootstrap 5, Chart.js, Font Awesome
- **Database**: SQLite (development), PostgreSQL/MySQL (production)
- **Styling**: CSS3 with Glass-morphism effects
- **Charts**: Chart.js for data visualization
- **Containerization**: Docker, Docker Compose
- **Orchestration**: Kubernetes
- **CI/CD**: Jenkins Pipeline
- **Infrastructure**: kubectl, Docker Engine

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Bootstrap** for the responsive UI framework
- **Chart.js** for beautiful data visualizations
- **Font Awesome** for icons
- **Flask** community for the excellent web framework

## 📞 Support

If you have any questions or need help with the application:

1. Check the [Issues](https://github.com/yourusername/Personal-Financial-Portal/issues) page
2. Create a new issue for bugs or feature requests
3. Contact the development team

---

**Made with ❤️ for better financial management**
