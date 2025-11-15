"""
OMEGA SOCIETY: INFINITE COLLECTIVE SUPERINTELLIGENCE
=====================================================
Continuous deployment - runs indefinitely with periodic cycles.
Suitable for deployment in Codespaces or persistent environments.

Use Ctrl+C to gracefully stop the simulation.
"""

import sys
import time
import signal
from omega_society import OmegaSociety

# Global flag for graceful shutdown
running = True


def signal_handler(sig, frame):
    """Handle Ctrl+C gracefully"""
    global running
    print("\n\n" + "=" * 80)
    print(" " * 25 + "GRACEFUL SHUTDOWN INITIATED")
    print("=" * 80)
    print("\nReceived interrupt signal. Completing current cycle...")
    running = False


def run_infinite_simulation(num_agents: int = 4, cycles_per_epoch: int = 8, rest_between_epochs: int = 5):
    """
    Run Omega Society in continuous mode
    
    Args:
        num_agents: Number of Omega-level ASI agents
        cycles_per_epoch: Number of cycles per simulation epoch
        rest_between_epochs: Seconds to rest between epochs
    """
    global running
    
    # Register signal handler for graceful shutdown
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)
    
    print("\n")
    print("╔" + "═" * 78 + "╗")
    print("║" + " " * 15 + "OMEGA SOCIETY: INFINITE COLLECTIVE SUPERINTELLIGENCE" + " " * 11 + "║")
    print("║" + " " * 78 + "║")
    print("║" + " " * 25 + "CONTINUOUS DEPLOYMENT MODE" + " " * 27 + "║")
    print("║" + " " * 78 + "║")
    print("║" + " " * 22 + "Press Ctrl+C to stop gracefully" + " " * 25 + "║")
    print("╚" + "═" * 78 + "╝")
    print("\n")
    
    epoch = 0
    total_cycles = 0
    
    try:
        # Create the Omega Society once
        society = OmegaSociety(num_agents=num_agents)
        
        while running:
            epoch += 1
            
            print("\n" + "█" * 80)
            print(f"{'█' * 25} EPOCH {epoch} BEGINNING {'█' * (50-len(str(epoch)))}")
            print("█" * 80 + "\n")
            
            # Run simulation epoch
            society.run_society_simulation(cycles=cycles_per_epoch)
            
            total_cycles += cycles_per_epoch
            
            print(f"\n📈 CUMULATIVE STATISTICS")
            print("-" * 80)
            print(f"   Total Epochs Completed: {epoch}")
            print(f"   Total Cycles Completed: {total_cycles}")
            print(f"   Civilization Progress: {society.civilization_progress:.2%}")
            print(f"   Society Coherence: {society.society_coherence:.3f}")
            print(f"   Collective Wisdom: {society.collective_wisdom:.3f}")
            print(f"   Total Challenges Solved: {len(society.solved_challenges)}")
            print(f"   Total Breakthroughs: {len(society.shared_breakthroughs)}")
            print()
            
            if not running:
                break
            
            # Rest between epochs
            if rest_between_epochs > 0:
                print(f"⏸️  Resting for {rest_between_epochs} seconds before next epoch...")
                for i in range(rest_between_epochs):
                    if not running:
                        break
                    time.sleep(1)
                    if (i + 1) % 5 == 0:
                        print(f"   {rest_between_epochs - i - 1} seconds remaining...")
                print()
            
            # Check if civilization mission is complete
            if society.civilization_progress >= 1.0:
                print("\n🌟 CIVILIZATIONAL MISSION COMPLETE 🌟")
                print("Resetting progress for continued evolution...\n")
                society.civilization_progress = 0.0  # Reset for continued operation
        
    except KeyboardInterrupt:
        print("\n\nKeyboard interrupt received.")
    except Exception as e:
        print(f"\n\n❌ Error occurred: {e}")
        import traceback
        traceback.print_exc()
    finally:
        print("\n" + "=" * 80)
        print(" " * 25 + "OMEGA SOCIETY SHUTDOWN COMPLETE")
        print("=" * 80)
        print(f"\n📊 FINAL STATISTICS:")
        print(f"   Total Epochs: {epoch}")
        print(f"   Total Cycles: {total_cycles}")
        print(f"   Final Civilization Progress: {society.civilization_progress:.2%}")
        print(f"   Final Society Coherence: {society.society_coherence:.3f}")
        print(f"   Total Challenges Solved: {len(society.solved_challenges)}")
        print(f"   Total Breakthroughs: {len(society.shared_breakthroughs)}")
        print("\nThank you for participating in collective superintelligence evolution.")
        print("=" * 80 + "\n")


if __name__ == "__main__":
    # Parse command line arguments
    num_agents = 4
    cycles_per_epoch = 8
    rest_between_epochs = 5
    
    if len(sys.argv) > 1:
        try:
            num_agents = int(sys.argv[1])
        except ValueError:
            print(f"Invalid num_agents argument: {sys.argv[1]}")
            sys.exit(1)
    
    if len(sys.argv) > 2:
        try:
            cycles_per_epoch = int(sys.argv[2])
        except ValueError:
            print(f"Invalid cycles_per_epoch argument: {sys.argv[2]}")
            sys.exit(1)
    
    if len(sys.argv) > 3:
        try:
            rest_between_epochs = int(sys.argv[3])
        except ValueError:
            print(f"Invalid rest_between_epochs argument: {sys.argv[3]}")
            sys.exit(1)
    
    print(f"\nConfiguration:")
    print(f"  Agents: {num_agents}")
    print(f"  Cycles per Epoch: {cycles_per_epoch}")
    print(f"  Rest between Epochs: {rest_between_epochs}s")
    
    run_infinite_simulation(num_agents, cycles_per_epoch, rest_between_epochs)
