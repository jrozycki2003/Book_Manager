#!/bin/bash
# Book Manager Pro - Quick Start Guide

echo "=========================================="
echo "Book Manager Pro - Setup Script"
echo "=========================================="
echo ""

# Check if Ruby is installed
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby is not installed. Please install Ruby 3.2+ first."
    exit 1
fi

echo "✅ Ruby found: $(ruby -v)"
echo ""

# Check if PostgreSQL is running
echo "Checking PostgreSQL connection..."
if ! psql -h localhost -U postgres -c "SELECT 1" &> /dev/null; then
    echo "⚠️  PostgreSQL may not be running. Make sure it's started."
    echo "   On Windows: Start PostgreSQL service"
    echo "   On macOS: brew services start postgresql"
    echo "   On Linux: sudo systemctl start postgresql"
fi

echo ""
echo "Installing dependencies..."
bundle install

echo ""
echo "Setting up database..."
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

echo ""
echo "=========================================="
echo "✅ Setup Complete!"
echo "=========================================="
echo ""
echo "To start the server, run:"
echo "  bin/rails server"
echo ""
echo "Default login credentials:"
echo "  Admin:"
echo "    Email: admin@bookmanager.com"
echo "    Password: password123"
echo ""
echo "  User 1:"
echo "    Email: john@example.com"
echo "    Password: password123"
echo ""
echo "  User 2:"
echo "    Email: jane@example.com"
echo "    Password: password123"
echo ""
echo "Application will be available at: http://localhost:3000"
echo ""
