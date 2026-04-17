# Whale Rider V4 Core Architecture 🐋

### High-Frequency Trading (HFT) Engine Skeleton | Castle Trade LLC

This repository contains the core architectural design and structural skeleton of **Whale Rider**, an institutional-grade HFT system designed to exploit inefficiencies in crypto-derivative market microstructure and order flow.

> **Note:** This is a **Skeleton Repository**. Proprietary execution logic, specific alpha signals, and private API integrations are excluded to protect **Castle Trade LLC** intellectual property. This code serves as a showcase of software engineering standards for mission-critical trading systems.

---

## 🏗️ Architectural Overview

The system is designed for ultra-low latency and absolute resilience, utilizing an asynchronous multi-process topology.

### Inter-Process Communication (IPC) & Shared Memory
Whale Rider operates via 6 specialized asynchronous processes interacting through an ultra-low latency data bus based on **Shared Memory (SHM)**:

1. **Process_0 (Data Ingestion):** Master writer for L2 Orderbook and Trade Tape.
2. **Process_1 (Alpha Engine):** Signal execution (Sniper) and Z-Score calculations.
3. **Process_2 (OMS & Risk):** Order management, persistence, and virtual accounting.
4. **Process_3 (C&C):** Human-machine interface and safety alerts.
5. **Process_4 (SMC Engine):** Market structure analysis and institutional bias.
6. **Process_5 (FVG/OB Engine):** Liquidity zone and order block identification.

### Key Engineering Features
* **Lock-Free Design:** Implementation of Sequential Markers to prevent read/write collisions without mutex overhead.
* **Fail-Safe Watchdog:** Real-time drift monitoring with atomic SIGKILL/Respawn protocols.
* **Institutional Risk Gates:** Triple-validation layers (Notional Guard, Friction Ratio, and ATR Grace Padding).

---

## 🛠️ Tech Stack

* **Language:** Python 3.10+ (Optimized for Linux kernels).
* **Infrastructure:** AWS Low-Latency EC2 Instances.
* **Persistence:** Atomic JSON Shadowing & REST/WebSocket Reconciliation.
* **Performance:** Shared Memory (SHM) IPC, Asyncio.

---

## 📂 Repository Structure (Roadmap)

- `/src`: Core asynchronous modules.
- `/risk`: Risk management and guard logic.
- `/docs`: Detailed architecture diagrams and SRE protocols.
- `/tests`: Unit tests for critical atomic functions.

---
**Developed and maintained by the Operations Division at Castle Trade LLC.**
