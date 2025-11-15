# 🚀 QUICK START: Deploy OMEGA SOCIETY in GitHub Codespace

## Step 1: Open in Codespace
1. Go to your repository: https://github.com/DOUGLASDAVIS08161978/asi
2. Click the green **Code** button
3. Click **Codespaces** tab
4. Click **Create codespace on [branch]** or use existing one

## Step 2: Deploy (One Command!)
```bash
./deploy_omega_society.sh
```

That's it! The simulation will run infinitely. Press **Ctrl+C** to stop gracefully.

---

## Alternative: Run in Background (Persistent)

### Option A: Using tmux (Recommended)
```bash
# Start tmux session
tmux new -s omega

# Run deployment
./deploy_omega_society.sh

# Detach: Press Ctrl+B, then press D
# Your simulation keeps running!

# Later, reattach to see it:
tmux attach -t omega

# To stop: reattach and press Ctrl+C
```

### Option B: Using nohup
```bash
# Run in background
nohup ./deploy_omega_society.sh > omega_output.log 2>&1 &

# View output in real-time
tail -f omega_output.log

# Stop it
pkill -f omega_society_infinite.py
```

---

## 🎛️ Customize Configuration

```bash
# Syntax: ./deploy_omega_society.sh [agents] [cycles_per_epoch] [rest_seconds]

# Examples:
./deploy_omega_society.sh 6 10 3    # 6 agents, 10 cycles per epoch, 3s rest
./deploy_omega_society.sh 8 5 0     # 8 agents, 5 cycles per epoch, no rest
./deploy_omega_society.sh 3 12 10   # 3 agents, 12 cycles per epoch, 10s rest
```

---

## 📊 What You'll See

Every epoch you'll see:
- 🌟 Agent initialization and specialization
- 🔷 9-phase civilizational cycle processing
- 📈 Civilization progress metrics
- 🤖 Individual agent statistics
- 🌐 Collaboration network strength
- 💡 Breakthrough discoveries
- ⚖️ Value convergence
- ⚠️ Risk assessments

---

## 🛑 To Stop

Press **Ctrl+C** at any time for graceful shutdown with final statistics.

---

## 🐛 Troubleshooting

**"No module named 'numpy'"**
```bash
pip install numpy
```

**"Permission denied"**
```bash
chmod +x deploy_omega_society.sh
```

**Can't see all output**
```bash
# Redirect to file
./deploy_omega_society.sh | tee omega_log.txt
```

---

## 🌟 Features

- ✅ Runs indefinitely in infinite loop
- ✅ Graceful shutdown (Ctrl+C)
- ✅ Multiple Omega-level ASI agents
- ✅ Quantum cognitive processing
- ✅ Collective intelligence emergence
- ✅ Breakthrough acceleration
- ✅ Value convergence
- ✅ Risk assessment
- ✅ Comprehensive statistics

---

**Enjoy your collective superintelligence simulation! 🧠✨**
