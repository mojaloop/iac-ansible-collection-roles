# Mojaloop IAC Ansible Collection

This repository contains a production-grade Ansible collection (`mojaloop.iac`) designed to automate the bootstrapping, deployment, and management of the Mojaloop infrastructure. It serves as the foundational automation layer for the [Mojaloop IaC Platform](https://github.com/mojaloop/iac-modules).

## Overview

The collection provides a suite of reusable roles and playbooks that handle everything from low-level Kubernetes installation to high-level platform service configuration. It is specifically optimized for **hybrid cloud** and **on-premises** environments, abstracting the complexity of bare-metal and virtualized (Proxmox) infrastructure.

## Key Capabilities

- **Cluster Bootstrapping**: Automated installation of **MicroK8s** (for environment clusters) and **kubeadm-based** clusters (for the Storage Cluster) using **Cluster API (CAPI)**.
- **Platform Orchestration**: Automated deployment of core services including **Argo CD**, **Vault**, **GitLab**, **Harbor**, and **Nexus**.
- **High-Availability Storage**: Dedicated roles and templates for managing **Rook/Ceph** and **OpenEBS** storage layers.
- **Mesh Networking**: Automation for **NetBird** client and server deployments, ensuring secure inter-cluster communication.
- **Governance & Security**: Integration with **Zitadel** for OIDC/SSO and automated PKI management via **Vault**.

## Collection Structure

### Roles

The collection is organized into specialized roles:

| Category | Roles |
| :--- | :--- |
| **Infrastructure** | `microk8s`, `k8s_node_common`, `docker`, `bastion_common` |
| **Platform Services** | `argocd`, `vault`, `harbor`, `nexus_server`, `netbird` |
| **Management** | `cc_k8s`, `gitlab_server`, `central_observability` |
| **Storage** | `seaweedfs_server`, `minio` (and integrated Rook/Ceph via `cc_k8s`) |
| **Testing** | `k6s_test_harness` |

### Playbooks

Key playbooks used in the deployment pipelines:

- **`control_center_deploy.yaml`**: The primary entry point for bootstrapping the Control Center (CC).
- **`ccmicrok8s_cluster_deploy.yaml`**: Specialized playbook for deploying the CC on MicroK8s infrastructure.
- **`argomicrok8s_cluster_deploy.yaml`**: Deploys Mojaloop environment clusters on MicroK8s, integrating them into the Argo CD management plane.
- **`test_harness_deploy.yaml`**: Provisions the infrastructure required for automated performance testing (K6s).

## Storage Cluster Management

A critical feature of this collection (found in the `feature/storage-cluster` branch) is the automation of the **Storage Cluster (SC)**. 

The collection orchestrates the deployment of the `storage-cluster-deployer` within Argo CD, which manages:
- **Rook/Ceph**: Provides distributed block, object, and file storage.
- **OpenEBS**: Used for local node storage, particularly for high-performance Kafka workloads.
- **Hybrid Overrides**: Support for overriding storage engines via configuration, allowing databases to leverage either Ceph or OpenEBS based on performance requirements.

## Configuration

Roles are highly customizable via `defaults/main.yml`. For production deployments, configuration is typically driven by the centralized `app_var_map` and `custom-config` files defined in the `iac-modules` repository.

## Integration with Mojaloop IaC

This collection is not intended to be used in isolation. It is triggered by the **OpenTofu/Terragrunt** pipelines in the `iac-modules` repository to handle the "procedural" parts of the infrastructure lifecycle that are better suited for Ansible than declarative IaC.
