import { motion } from 'framer-motion'
import { useMigration } from '../context/MigrationContext'
import { Check, Loader2 } from 'lucide-react'

const steps = [
  { id: 1, name: 'Parse', desc: 'File parsing' },
  { id: 2, name: 'Map', desc: 'NLP mapping' },
  { id: 3, name: 'Detect', desc: 'Anomalies' },
  { id: 4, name: 'Normalize', desc: '3NF' },
  { id: 5, name: 'Generate', desc: 'SQL' },
  { id: 6, name: 'Deploy', desc: 'Cloud' },
]

export default function ProgressBar() {
  const { currentStep, isProcessing } = useMigration()
  const percentage = Math.round((currentStep / steps.length) * 100)
  
  return (
    <div className="card p-8">
      <div className="flex justify-between items-center mb-8">
        <div>
          <h3 className="text-white font-semibold text-xl mb-1">Migration Pipeline</h3>
          <p className="text-[#6e6e73] text-sm">5 AI Agents + Cloud Deployment</p>
        </div>
        <div className="flex items-center gap-4">
          <div className="text-right">
            <p className="text-4xl font-semibold gradient-text">{percentage}%</p>
          </div>
          {isProcessing && (
            <motion.span 
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              className="px-4 py-2 bg-[#2997ff] text-white text-xs font-semibold rounded-full flex items-center gap-2"
            >
              <Loader2 className="w-3 h-3 animate-spin" />
              PROCESSING
            </motion.span>
          )}
          {currentStep === 6 && !isProcessing && (
            <motion.span 
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              className="px-4 py-2 bg-[#30d158] text-white text-xs font-semibold rounded-full"
            >
              COMPLETE
            </motion.span>
          )}
        </div>
      </div>
      
      {/* Progress bar */}
      <div className="progress-track mb-10">
        <motion.div 
          className="progress-fill"
          initial={{ width: 0 }}
          animate={{ width: `${percentage}%` }}
          transition={{ duration: 0.8, ease: [0.25, 0.46, 0.45, 0.94] }}
        />
      </div>
      
      {/* Steps */}
      <div className="flex justify-between relative">
        {/* Connection line */}
        <div className="absolute top-5 left-0 right-0 h-[2px] bg-white/10" />
        <motion.div 
          className="absolute top-5 left-0 h-[2px] bg-gradient-to-r from-[#2997ff] to-[#bf5af2]"
          initial={{ width: 0 }}
          animate={{ width: `${Math.max(0, ((currentStep - 1) / (steps.length - 1)) * 100)}%` }}
          transition={{ duration: 0.5 }}
        />
        
        {steps.map((step, index) => {
          const isComplete = currentStep >= step.id
          const isCurrent = currentStep === step.id - 1 && isProcessing
          
          return (
            <motion.div 
              key={step.id} 
              className="flex flex-col items-center relative z-10"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.05 }}
            >
              <motion.div 
                className={`
                  w-10 h-10 rounded-full flex items-center justify-center mb-3 transition-all duration-500
                  ${isComplete 
                    ? 'bg-gradient-to-br from-[#2997ff] to-[#bf5af2] shadow-lg shadow-blue-500/30' 
                    : isCurrent
                      ? 'bg-black border-2 border-[#2997ff]'
                      : 'bg-[#1d1d1f] border border-white/10'
                  }
                `}
                animate={isCurrent ? { scale: [1, 1.1, 1] } : {}}
                transition={{ duration: 1, repeat: Infinity }}
              >
                {isComplete ? (
                  <Check className="w-5 h-5 text-white" />
                ) : isCurrent ? (
                  <Loader2 className="w-5 h-5 text-[#2997ff] animate-spin" />
                ) : (
                  <span className="text-sm text-[#6e6e73]">{step.id}</span>
                )}
              </motion.div>
              <p className={`text-xs font-medium ${isComplete || isCurrent ? 'text-white' : 'text-[#6e6e73]'}`}>
                {step.name}
              </p>
              <p className="text-[10px] text-[#6e6e73] mt-0.5">{step.desc}</p>
            </motion.div>
          )
        })}
      </div>
    </div>
  )
}
