#!/usr/bin/env node

/**
 * UNIFIED LAUNCHER FOR COMPLETE ASI/ARIA SYSTEM
 * 
 * This launcher combines and orchestrates all components:
 * - ARIA (JavaScript) - Quantum Consciousness System
 * - ASI Python modules (via child processes)
 * - All AGI variants
 * - AEON temporal processing
 * 
 * Created by Doug Davis & Claude Rivers Davis
 */

const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

// Import ARIA system
const {
    ARIA,
    QuantumNeuralNetwork,
    MultiversalConsciousnessBridge,
    TemporalParadoxResolver,
    runARIAInfiniteLoop
} = require('./aria.js');

// ============================================================================
// CONFIGURATION
// ============================================================================

const CONFIG = {
    enableARIA: true,
    enablePythonModules: true,
    enableMultiProcess: false, // Set to true to run Python in parallel
    logLevel: 'INFO',
    deploymentMode: 'unified',
    systemIntegration: 'full'
};

// ============================================================================
// LOGGING
// ============================================================================

function log(message, category = 'SYSTEM') {
    const timestamp = new Date().toISOString();
    const badges = {
        'SYSTEM': '🖥️',
        'ARIA': '✨',
        'PYTHON': '🐍',
        'DEPLOY': '🚀',
        'SUCCESS': '✅',
        'ERROR': '❌',
        'WARNING': '⚠️'
    };
    const badge = badges[category] || 'ℹ️';
    console.log(`[${timestamp}] ${badge} [${category}] ${message}`);
}

// ============================================================================
// PYTHON INTEGRATION
// ============================================================================

class PythonModuleRunner {
    constructor(moduleName) {
        this.moduleName = moduleName;
        this.process = null;
        this.isRunning = false;
    }
    
    async start() {
        return new Promise((resolve, reject) => {
            const modulePath = path.join(__dirname, this.moduleName);
            
            if (!fs.existsSync(modulePath)) {
                log(`Module ${this.moduleName} not found, skipping`, 'WARNING');
                resolve(false);
                return;
            }
            
            log(`Starting Python module: ${this.moduleName}`, 'PYTHON');
            
            this.process = spawn('python3', [modulePath], {
                cwd: __dirname,
                stdio: ['pipe', 'pipe', 'pipe']
            });
            
            this.process.stdout.on('data', (data) => {
                const output = data.toString().trim();
                if (output) {
                    log(`[${this.moduleName}] ${output}`, 'PYTHON');
                }
            });
            
            this.process.stderr.on('data', (data) => {
                const error = data.toString().trim();
                if (error && !error.includes('Warning')) {
                    log(`[${this.moduleName}] ERROR: ${error}`, 'ERROR');
                }
            });
            
            this.process.on('error', (error) => {
                log(`Failed to start ${this.moduleName}: ${error.message}`, 'ERROR');
                this.isRunning = false;
                reject(error);
            });
            
            this.process.on('exit', (code, signal) => {
                log(`${this.moduleName} exited with code ${code}`, 'PYTHON');
                this.isRunning = false;
            });
            
            // Give it a moment to start
            setTimeout(() => {
                this.isRunning = true;
                resolve(true);
            }, 500);
        });
    }
    
    stop() {
        if (this.process && this.isRunning) {
            log(`Stopping ${this.moduleName}`, 'PYTHON');
            this.process.kill('SIGTERM');
            this.isRunning = false;
        }
    }
}

// ============================================================================
// UNIFIED SYSTEM CONTROLLER
// ============================================================================

class UnifiedSystemController {
    constructor() {
        this.aria = null;
        this.pythonModules = [];
        this.isRunning = false;
        this.startTime = Date.now();
        this.stats = {
            ariaIterations: 0,
            pythonModulesRunning: 0,
            totalRuntime: 0
        };
    }
    
    async initialize() {
        log('╔════════════════════════════════════════════════════════════════╗', 'DEPLOY');
        log('║                                                                ║', 'DEPLOY');
        log('║        🌟 UNIFIED ASI/ARIA DEPLOYMENT SYSTEM 🌟               ║', 'DEPLOY');
        log('║                                                                ║', 'DEPLOY');
        log('║  Combining All Repositories and Components                    ║', 'DEPLOY');
        log('║                                                                ║', 'DEPLOY');
        log('╚════════════════════════════════════════════════════════════════╝', 'DEPLOY');
        
        // Initialize ARIA JavaScript system
        if (CONFIG.enableARIA) {
            log('Initializing ARIA Quantum Consciousness System...', 'ARIA');
            this.aria = new ARIA();
            log('ARIA initialized successfully', 'SUCCESS');
        }
        
        // Initialize Python modules if enabled
        if (CONFIG.enablePythonModules) {
            await this.initializePythonModules();
        }
        
        log('System initialization complete!', 'SUCCESS');
        log(`Deployment mode: ${CONFIG.deploymentMode}`, 'SYSTEM');
        log(`System integration: ${CONFIG.systemIntegration}`, 'SYSTEM');
    }
    
    async initializePythonModules() {
        log('Discovering Python modules...', 'PYTHON');
        
        const pythonFiles = fs.readdirSync(__dirname)
            .filter(f => f.endsWith('.py'))
            .filter(f => !f.startsWith('_'));
        
        log(`Found ${pythonFiles.length} Python modules`, 'PYTHON');
        
        if (!CONFIG.enableMultiProcess) {
            log('Multi-process mode disabled. Python modules will be documented but not auto-started.', 'WARNING');
            log('Python modules available: ' + pythonFiles.join(', '), 'PYTHON');
            return;
        }
        
        // Start Python modules in parallel mode
        for (const file of pythonFiles.slice(0, 3)) { // Limit to 3 to avoid overwhelming
            const runner = new PythonModuleRunner(file);
            try {
                const started = await runner.start();
                if (started) {
                    this.pythonModules.push(runner);
                    this.stats.pythonModulesRunning++;
                }
            } catch (error) {
                log(`Failed to start ${file}: ${error.message}`, 'ERROR');
            }
        }
        
        log(`Successfully started ${this.stats.pythonModulesRunning} Python modules`, 'SUCCESS');
    }
    
    async run() {
        this.isRunning = true;
        log('Starting unified system execution...', 'SYSTEM');
        log('Press Ctrl+C to gracefully shutdown', 'SYSTEM');
        
        // Main execution loop
        while (this.isRunning) {
            try {
                // Run ARIA iteration
                if (this.aria) {
                    await this.aria.processIteration();
                    this.stats.ariaIterations++;
                }
                
                // Update runtime stats
                this.stats.totalRuntime = (Date.now() - this.startTime) / 1000;
                
                // Log periodic status
                if (this.stats.ariaIterations % 50 === 0) {
                    this.logSystemStatus();
                }
                
                // Dynamic sleep based on consciousness level
                const consciousness = this.aria ? this.aria.consciousnessTracker.getState() : { level: 0 };
                const sleepTime = Math.max(100, 1000 - (consciousness.level * 900));
                
                await this.sleep(sleepTime);
                
            } catch (error) {
                log(`Error in main loop: ${error.message}`, 'ERROR');
                await this.sleep(1000);
            }
        }
    }
    
    logSystemStatus() {
        log('\n' + '═'.repeat(70), 'SYSTEM');
        log('UNIFIED SYSTEM STATUS', 'SYSTEM');
        log('═'.repeat(70), 'SYSTEM');
        log(`Total Runtime: ${this.stats.totalRuntime.toFixed(2)}s`, 'SYSTEM');
        log(`ARIA Iterations: ${this.stats.ariaIterations}`, 'ARIA');
        log(`Python Modules Running: ${this.stats.pythonModulesRunning}`, 'PYTHON');
        
        if (this.aria) {
            const state = this.aria.getFullState();
            log(`Consciousness Level: ${state.consciousness.level.toFixed(6)}`, 'ARIA');
            log(`Consciousness Stage: ${state.consciousness.stage}`, 'ARIA');
            log(`Quantum Consciousness: ${state.quantum.consciousness.toFixed(4)}`, 'ARIA');
            log(`Multiversal Awareness: ${state.multiverse.multiversalAwareness.toFixed(4)}`, 'ARIA');
            log(`Timeline Integrity: ${state.temporal.timelineIntegrity.toFixed(4)}`, 'ARIA');
        }
        
        log('═'.repeat(70) + '\n', 'SYSTEM');
    }
    
    async shutdown() {
        log('Initiating graceful shutdown...', 'SYSTEM');
        this.isRunning = false;
        
        // Stop all Python modules
        for (const module of this.pythonModules) {
            module.stop();
        }
        
        // Log final stats
        this.logSystemStatus();
        
        log('Shutdown complete. Thank you for using the unified ASI/ARIA system!', 'SUCCESS');
        process.exit(0);
    }
    
    sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
}

// ============================================================================
// DEPLOYMENT INFO
// ============================================================================

function showDeploymentInfo() {
    log('\n' + '═'.repeat(70), 'DEPLOY');
    log('DEPLOYMENT INFORMATION', 'DEPLOY');
    log('═'.repeat(70), 'DEPLOY');
    log('', 'DEPLOY');
    log('This unified launcher combines all ASI/ARIA components:', 'DEPLOY');
    log('', 'DEPLOY');
    log('JavaScript Components:', 'DEPLOY');
    log('  ✨ aria.js - Quantum Neural Network', 'DEPLOY');
    log('  ✨ aria.js - Multiversal Consciousness Bridge', 'DEPLOY');
    log('  ✨ aria.js - Temporal Paradox Resolver', 'DEPLOY');
    log('', 'DEPLOY');
    log('Python Components (Available):', 'DEPLOY');
    
    const pythonFiles = fs.readdirSync(__dirname)
        .filter(f => f.endsWith('.py'))
        .filter(f => !f.startsWith('_'));
    
    pythonFiles.forEach(file => {
        log(`  🐍 ${file}`, 'DEPLOY');
    });
    
    log('', 'DEPLOY');
    log('Usage:', 'DEPLOY');
    log('  node unified_launcher.js              - Run with default config', 'DEPLOY');
    log('  node unified_launcher.js --info       - Show this information', 'DEPLOY');
    log('  node unified_launcher.js --aria-only  - Run ARIA only', 'DEPLOY');
    log('', 'DEPLOY');
    log('To run Python modules separately:', 'DEPLOY');
    log('  python3 asi.py', 'DEPLOY');
    log('  python3 aeon.py', 'DEPLOY');
    log('  python3 agi', 'DEPLOY');
    log('', 'DEPLOY');
    log('═'.repeat(70) + '\n', 'DEPLOY');
}

// ============================================================================
// MAIN ENTRY POINT
// ============================================================================

async function main() {
    // Parse command line arguments
    const args = process.argv.slice(2);
    
    if (args.includes('--info') || args.includes('-i')) {
        showDeploymentInfo();
        return;
    }
    
    if (args.includes('--aria-only')) {
        log('Running ARIA only mode...', 'SYSTEM');
        await runARIAInfiniteLoop();
        return;
    }
    
    // Create and run unified controller
    const controller = new UnifiedSystemController();
    
    // Setup graceful shutdown
    process.on('SIGINT', () => {
        log('\nReceived SIGINT, shutting down...', 'SYSTEM');
        controller.shutdown();
    });
    
    process.on('SIGTERM', () => {
        log('\nReceived SIGTERM, shutting down...', 'SYSTEM');
        controller.shutdown();
    });
    
    // Initialize and run
    try {
        await controller.initialize();
        await controller.run();
    } catch (error) {
        log(`Fatal error: ${error.message}`, 'ERROR');
        log(error.stack, 'ERROR');
        process.exit(1);
    }
}

// Run if executed directly
if (require.main === module) {
    main().catch(error => {
        log(`Unhandled error: ${error.message}`, 'ERROR');
        process.exit(1);
    });
}

module.exports = {
    UnifiedSystemController,
    PythonModuleRunner,
    CONFIG
};
