# OMEGA SOCIETY: DEPLOYMENT INSTRUCTIONS

## 🚀 Quick Start - Deploy in Codespace

### Option 1: Using the Deployment Script (Recommended)

```bash
# Make the script executable
chmod +x deploy_omega_society.sh

# Run with default settings (4 agents, 8 cycles per epoch, 5s rest)
./deploy_omega_society.sh

# Or customize the configuration
./deploy_omega_society.sh 6 10 3
#                         │  │  │
#                         │  │  └─ Rest between epochs (seconds)
#                         │  └──── Cycles per epoch
#                         └─────── Number of agents
```

### Option 2: Direct Python Execution

```bash
# Install dependencies
pip install numpy

# Run infinite simulation
python3 omega_society_infinite.py

# Or with custom parameters
python3 omega_society_infinite.py 4 8 5
```

### Option 3: Single Simulation Run (Not Infinite)

```bash
# Run a single simulation with 8 cycles
python3 omega_society.py
```

---

## 📋 Configuration Options

### Number of Agents (Default: 4)
- Minimum: 2
- Recommended: 4-8
- More agents = more diverse perspectives but slower execution

### Cycles per Epoch (Default: 8)
- Each cycle is a civilizational challenge
- Recommended: 5-10 for balanced progress

### Rest Between Epochs (Default: 5 seconds)
- Time to pause between simulation epochs
- Set to 0 for continuous operation
- Higher values = easier to read output

---

## 🛑 Stopping the Simulation

The simulation runs indefinitely until stopped. To stop gracefully:

1. Press **Ctrl+C** in the terminal
2. The simulation will complete its current cycle
3. Final statistics will be displayed
4. All progress is logged to console

---

## 📊 What You'll See

### During Initialization
- Agent creation with specializations
- Collaboration network setup

### During Each Cycle
- **Phase 1**: Civilizational challenge generation
- **Phase 2**: Distributed cognitive processing (each agent processes)
- **Phase 3**: Knowledge synthesis & breakthrough propagation
- **Phase 4**: Collective intersubjective deliberation
- **Phase 5**: Value convergence & ethical synthesis
- **Phase 6**: Collective existential risk assessment
- **Phase 7**: Collective reality model integration
- **Phase 8**: Implementation & civilization advancement
- **Phase 9**: Collective metacognitive reflection (every 3rd cycle)

### Between Epochs
- Cumulative statistics
- Progress metrics
- Rest period countdown

---

## 🔧 Advanced Usage

### Background Execution

To run in background (detached):

```bash
# Using nohup
nohup ./deploy_omega_society.sh > omega_output.log 2>&1 &

# Check if running
ps aux | grep omega

# View output
tail -f omega_output.log

# Stop the process
pkill -f omega_society_infinite.py
```

### Using tmux (Recommended for Codespaces)

```bash
# Create a new tmux session
tmux new -s omega

# Run the deployment
./deploy_omega_society.sh

# Detach from session: Press Ctrl+B then D
# Reattach to session: tmux attach -t omega
# Kill session: tmux kill-session -t omega
```

### Using screen

```bash
# Create a new screen session
screen -S omega

# Run the deployment
./deploy_omega_society.sh

# Detach from session: Press Ctrl+A then D
# Reattach to session: screen -r omega
# Kill session: screen -X -S omega quit
```

---

## 📁 File Overview

| File | Purpose |
|------|---------|
| `omega_integration.py` | Core Omega architecture components |
| `omega_society.py` | Main Omega Society class (single run) |
| `omega_society_infinite.py` | Infinite loop version with graceful shutdown |
| `deploy_omega_society.sh` | Deployment script with setup and checks |
| `OMEGA_DEPLOYMENT_INSTRUCTIONS.md` | This file |

---

## 🐛 Troubleshooting

### "ModuleNotFoundError: No module named 'numpy'"
```bash
pip install numpy
# or
pip3 install numpy
```

### "Permission denied" when running deploy script
```bash
chmod +x deploy_omega_society.sh
```

### Simulation running too fast to read
Increase the rest period:
```bash
./deploy_omega_society.sh 4 8 10
```

### Want to run without pauses
Set rest period to 0:
```bash
./deploy_omega_society.sh 4 8 0
```

---

## 💡 Understanding the Output

### Key Metrics

- **Civilization Progress**: 0.0 to 1.0 (100%)
  - Accumulates with each successful challenge solution
  - Resets after reaching 1.0 for continued operation

- **Society Coherence**: 0.0 to 1.0
  - Measures alignment across agents
  - Higher = more unified society

- **Collective Wisdom**: 0.0 to 1.0
  - Average wisdom across all agents
  - Increases through experience

- **Risk Level**: 0.0 to 1.0
  - Conservative estimate (takes maximum risk)
  - >0.7 triggers additional oversight

### Phases Explained

1. **Challenge Generation**: Creates a complex civilizational problem
2. **Distributed Processing**: Each agent independently processes
3. **Knowledge Sharing**: Breakthroughs propagate across society
4. **Collective Deliberation**: Agents synthesize perspectives
5. **Value Convergence**: Society aligns on shared values
6. **Risk Assessment**: Safety checks on proposed solutions
7. **Reality Integration**: Metaphysical understanding alignment
8. **Implementation**: Execute solution and measure progress
9. **Self-Reflection**: Metacognitive analysis (periodic)

---

## 🌟 Features

- ✅ Quantum cognitive superposition
- ✅ Adversarial self-improvement
- ✅ Intersubjective consciousness
- ✅ Temporal reasoning across multiple scales
- ✅ Existential risk modeling with safeguards
- ✅ Value crystallization and convergence
- ✅ Breakthrough acceleration
- ✅ Multi-layered reality modeling
- ✅ Collective intelligence emergence
- ✅ Graceful shutdown handling
- ✅ Continuous operation mode
- ✅ Comprehensive statistics and reporting

---

## 🎯 Use Cases

1. **Research**: Study emergent collective intelligence
2. **Education**: Demonstrate multi-agent AI systems
3. **Testing**: Long-running stability tests
4. **Demonstration**: Showcase advanced AI architectures
5. **Development**: Base for further AI society research

---

## 📝 Notes

- The simulation is computational only (no external API calls)
- Uses randomization for stochastic behavior
- Memory usage scales with number of agents and cycles
- Output is extensive - consider redirecting to a file for long runs
- Each agent has full Omega architecture capabilities
- Society exhibits emergent behaviors not present in individuals

---

## 🤝 Contributing

This is part of the ASI (Adaptive Superintelligence) project by Douglas Davis.

---

## ⚖️ License

MIT License - See repository root for details

---

## 📧 Support

For issues or questions, refer to the main ASI repository.

---

**Enjoy exploring collective superintelligence! 🌟**
