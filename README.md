# Whale Rider V4 Core | HFT Infrastructure

This repository contains the core orchestration and risk management infrastructure for Whale Rider V4, a high-frequency trading (HFT) system designed for institutional-grade execution and low-latency market interaction.

## Architecture Overview

The system follows a decoupled, multi-process architecture to ensure maximum throughput and fault tolerance. Each mission-critical component operates in a dedicated OS process, communicating via low-latency IPC mechanisms.

### Memory Management (SHM)

Whale Rider utilizes POSIX Shared Memory (SHM) for zero-copy data transfer between the Market Data Handlers and the Alpha Engine. This topology minimizes the overhead of inter-process communication (IPC) and ensures that the order execution path remains deterministic.

- **Lock-free Circular Buffers**: Used for queuing market data updates.
- **Memory Mapping**: All critical state is held in mapped memory for rapid recovery and SRE observability.

### IPC Topology

The internal communication grid is structured into specific tiers:
1. **Market Data Feed (L1/L2)**: High-bandwidth, read-only ingestion via WebSocket/FIX.
2. **Strategy Channel**: Low-latency signals transmitted from Alpha to OMS.
3. **Control Plane**: Asynchronous management commands for risk overrides and emergency decommissioning.

### SRE Disaster Recovery

Operational resilience is managed through a tiered "Safeguard" protocol:
- **Level 1: Local Guardian**: Real-time validation of every outbound order (Notional Guard).
- **Level 2: Heartbeat Monitor**: Orchestrator-level checks on worker health; auto-restart or fail-close on process death.
- **Level 3: Global Circuit Breaker**: Remote kill-switch capability for entire portfolio exposure in event of catastrophic market shifts.

## Technical Configuration

### Prerequisites
- Python 3.11+
- uvloop
- AWS Nitro System (Recommended for production)

### Installation
```bash
pip install -r requirements.txt
```

### Deployment (AWS)
Refer to the provided `Dockerfile` for standardized containerization. The infrastructure is designed to be deployed on `c6i` or `c7g` instances for optimal CPU pinning and network stack performance.

---
**Technical Note**: This repository serves as a skeleton framework demonstrating system architecture and engineering patterns. Proprietary execution logic (Alpha) is abstracted through internal interfaces.

(c) 2026 Castle Trade LLC. Proprietary and Confidential.
