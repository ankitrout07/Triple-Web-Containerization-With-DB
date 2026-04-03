# 🏗️ Triple-Web-DB: Tiered Overflow Architecture

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)](https://mariadb.org/)
[![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com/)

A professional, production-grade multi-tier infrastructure demonstrating **High-Availability (HA)** through a **Tiered Overflow** strategy. Built on Ubuntu and orchestrated with Docker Compose, this stack features automated load balancing, self-initializing persistent storage, and a premium administrative audit layer.

---

## 🛰️ Architecture Overview

The system implements a hierarchical traffic distribution model designed to handle bursty workloads by spilling over into redundant backup nodes.

```mermaid
graph TD
    User((User Traffic)) --> LB[Nginx Load Balancer]
    
    subgraph "High Availability Web Tier"
        LB -- "1. Primary (max_conns=20)" --> Alpha[Web ALPHA]
        LB -- "2. Backup" --> Beta[Web BETA]
        LB -- "3. Backup (Deep)" --> Gamma[Web GAMMA]
    end
    
    subgraph "Persistence Layer"
        Alpha --> DB[(MariaDB Cluster)]
        Beta --> DB
        Gamma --> DB
    end
    
    style Alpha fill:#6366f1,stroke:#fff,stroke-width:2px
    style Beta fill:#475569,stroke:#fff,stroke-opacity:0.5
    style Gamma fill:#475569,stroke:#fff,stroke-opacity:0.5
    style DB fill:#10b981,stroke:#fff,stroke-width:2px
```

---

## 🌟 Key Features

- **⚡ Tiered Overflow Strategy**: Traffic is prioritized to the **ALPHA** node. If connection limits are reached (simulating high CPU/Memory load), Nginx dynamically spills traffic to **BETA** and **GAMMA** nodes.
- **📦 Auto-Initializing Database**: The stack includes a `schema.sql` that automatically creates the `app_db` and `site_logins` tables on the first launch.
- **🎨 Premium UI/UX**: State-of-the-art Glassmorphic interfaces for both the user gateway and administrative audit logs, featuring mesh gradients and micro-animations.
- **📊 Infrastructure Observability**: Built-in `health_monitor.sh` script for real-time resource tracking and traffic route verification.
- **🔒 Environment Isolation**: Fully parameterized configuration via environment variables for easy deployment across staging and production.

---

## 🚀 Quick Start

1. **Clone and Initialize**:
   ```bash
   git clone https://github.com/ankitrout07/Triple-Web-Containerization-With-DB.git
   cd Triple-Web-Containerization-With-DB
   ```

2. **Launch Infrastructure**:
   ```bash
   docker compose up -d --build
   ```

3. **Verify Deployment**:
   - **Gateway**: [http://localhost](http://localhost)
   - **Audit Log**: [http://localhost/admin](http://localhost/admin)
   - **Monitor**: `./scripts/health_monitor.sh`

---

## 📂 Project Structure

```text
.
├── src/
│   └── web/            # Unified Flask Source & Template Engine
├── infrastructure/     # Service-specific configurations
│   ├── nginx/          # Load Balancer policies
│   └── mariadb/        # Automated DB Schema injection
├── scripts/            # DevOps Monitoring & Maintenance
├── docs/               # Technical notes & command references
└── docker-compose.yml  # Global orchestration manifest
```

---

## 🔧 Component Breakdown

### Web Service (`src/web`)
A modular Flask application that uses `os.environ` to dynamically adapt its identity (Alpha/Beta/Gamma) and database connection strings.

### Load Balancer (`infrastructure/nginx`)
Nginx is utilized as a reverse proxy with a custom `upstream` configuration:
```nginx
upstream myapp {
    server web1:80 max_conns=20;
    server web2:80 max_conns=20 backup;
    server web3:80 backup;
}
```

### Database Cluster (`infrastructure/mariadb`)
MariaDB 10.6 with persistent volume mounting for the `db_data` directory, ensuring no data loss between container restarts.

---

## 👥 Contributors & Contact

**Ankit Anupam Rout** - *Project Lead / DevOps Architect*
- GitHub: [@ankitrout07](https://github.com/ankitrout07)

---
*Generated with ❤️ by Antigravity*
