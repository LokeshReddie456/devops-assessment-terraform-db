# DevOps Assessment: Terraform Infrastructure & Database Reliability

Production-grade repository containing modular Terraform configurations for AWS and a containerized PostgreSQL environment demonstrating automated migrations, seeding, query optimization, and disaster recovery.

---

## 1. Architectural Blueprint

```text
                     Internet
                        |
                        v
       +---------------------------------+
       |   Application Load Balancer     | [Public Subnets: AZ-a, AZ-b]
       |   (Security Group: Inbound :80) |
       +----------------+----------------+
                        | HTTP :80
                        v
       +---------------------------------+
       |     AWS ECS / Fargate Tasks     | [Private Subnets: AZ-a, AZ-b]
       |   (Security Group: From ALB SG) |
       +----------------+----------------+
                        | TCP :5432
                        v
       +---------------------------------+
       |      Amazon RDS PostgreSQL      | [Private Subnets: Multi-AZ]
       |   (Security Group: From ECS SG) | (Zero Internet Gateway Routes)
       +---------------------------------+