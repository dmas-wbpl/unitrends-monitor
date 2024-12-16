#!/bin/bash


mkdir -p .github/{workflows,ISSUE_TEMPLATE} docs scripts frontend backend

# Create GitHub workflow files
cat > .github/workflows/ci.yml << EOL
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      # Add test steps
EOL

cat > .github/workflows/cd.yml << EOL
name: CD

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      # Add deployment steps
EOL

# Create frontend structure
cd $PROJECT_DIR/frontend
mkdir -p src/{components/{common,layout,features},hooks,pages,services,types,utils} public tests/{unit,integration}

# Create backend structure
cd $PROJECT_DIR/backend
mkdir -p app/{api/v1/{endpoints,deps},core,db,models,schemas,services} tests/{unit,integration} alembic requirements

# Create configuration files
cd $PROJECT_DIR

# Create .cursorrules
cat > .cursorrules << EOL
# Project-Specific Rules

## Naming Conventions
- Components: PascalCase
- Hooks: camelCase with 'use' prefix
- API routes: kebab-case
- Database tables: snake_case
- Type definitions: PascalCase

## Component Requirements
- Use TypeScript
- Implement error boundaries
- Follow atomic design
- Include proper documentation
- Add unit tests

## API Integration
- Use React Query
- Implement error handling
- Use TypeScript types
- Follow RESTful conventions
- Include loading states

## Testing Requirements
- Unit tests: 80% coverage
- Integration tests
- E2E tests for critical flows
- API tests
EOL

# Create .editorconfig
cat > .editorconfig << EOL
root = true

[*]
end_of_line = lf
insert_final_newline = true
charset = utf-8
indent_style = space
indent_size = 2
trim_trailing_whitespace = true

[*.py]
indent_size = 4

[Makefile]
indent_style = tab
EOL

# Create .gitignore
cat > .gitignore << EOL
# Dependencies
node_modules/
venv/
.env

# Build
dist/
build/
*.pyc

# IDE
.idea/
.vscode/
*.swp

# Testing
coverage/
.pytest_cache/

# System
.DS_Store
Thumbs.db
EOL

# Create README files
cat > README.md << EOL
# $PROJECT_NAME

## Overview
Brief project description

## Quick Start
1. Prerequisites
2. Installation
3. Configuration
4. Running locally

## Documentation
- [Project Documentation](docs/PROJECT.md)
- [API Documentation](docs/API.md)
- [Architecture](docs/ARCHITECTURE.md)

## Development
- Coding standards
- Testing
- Contributing guidelines

## Deployment
- Staging
- Production
- CI/CD
EOL

cat > frontend/README.md << EOL
# Frontend

## Technology Stack
- React with TypeScript
- Material-UI
- React Query
- Tailwind CSS
- Vite

## Development
1. Setup
2. Available scripts
3. Testing
4. Building

## Project Structure
Explanation of directory structure
EOL

cat > backend/README.md << EOL
# Backend

## Technology Stack
- Python/FastAPI
- PostgreSQL
- SQLAlchemy
- Alembic
- Pytest

## Development
1. Setup
2. Database migrations
3. Testing
4. API documentation

## Project Structure
Explanation of directory structure
EOL

# Create empty package.json and requirements files
echo '{}' > frontend/package.json
touch backend/requirements/{base.txt,dev.txt,prod.txt}

echo "Project structure created successfully at $PROJECT_DIR"
echo "Next steps:"
echo "1. cd $PROJECT_NAME"
echo "2. git init"
echo "3. npm init (in frontend directory)"
echo "4. python -m venv venv (in backend directory)"
