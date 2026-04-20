# 🐋 Whale Rider V4 - Core HFT Infrastructure

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> **Property of Castle Trade LLC.** Institutional-grade execution architecture designed for high-frequency market engagement.

## About
`whale-rider-v4-core` is the backbone of Castle Trade's algorithmic operations. It provides a mission-critical, low-latency framework for multi-process orchestration, risk management, and shared memory communication. This repository contains the "Skeleton" architecture of the system, showcasing high-level design patterns used in institutional quant environments.

### Core Architecture
- **Multi-Process Orchestration**: Utilizing Python's `multiprocessing` for isolated, parallel execution and crash recovery.
- **IPC Shared Memory Topology**: High-performance data exchange using memory-mapped buffers for ticker data and order state, avoiding traditional serialization overhead.
- **Lock-Free Sequential Markers**: Implementation of sequential consistency markers for ticker processing to ensure ultra-low latency without mutex contention.
- **Heartbeat Monitoring**: Real-time health checks between the orchestrator and sub-engines to ensure zero-downtime operations.

## Repository Structure
- `src/core/main_launcher.py`: The central orchestrator for system initialization and lifecycle management.
- `src/risk/gatekeeper.py`: Pre-trade risk validation engine implementing "Notional Guard" and "Friction Ratio" checks.
- `scripts/sre_cleanup.sh`: Site Reliability Engineering utility for system reset and memory purging.

## Engineering Standards
- **Memory Management**: Optimized for `/dev/shm` environments.
- **SRE Protocols**: Automated environment sanitization and resource reclamation.
- **Error Handling**: Comprehensive try-except blocks with institutional-grade logging.

---
*Disclaimer: This repository contains architectural skeletons and does not include proprietary alpha-generation logic or live trading parameters. Unauthorized duplication of Castle Trade LLC infrastructure is prohibited.*
