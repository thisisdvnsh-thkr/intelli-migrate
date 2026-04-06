import { motion } from 'framer-motion'
import { GitBranch, ArrowRight, Check, Sparkles } from 'lucide-react'
import { useMigration } from '../context/MigrationContext'

export default function SchemaMapping({ compact = false }) {
  const { mappingResult } = useMigration()
  
  if (!mappingResult?.mappings?.length) {
    return (
      <div className="card p-8">
        <h3 className="text-white font-semibold text-lg mb-6 flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-[#bf5af2] to-[#da8fff] flex items-center justify-center">
            <GitBranch className="w-5 h-5 text-white" />
          </div>
          Schema Mapping
        </h3>
        <div className="text-center py-12">
          <div className="w-20 h-20 mx-auto mb-6 rounded-full bg-[#bf5af2]/10 flex items-center justify-center">
            <GitBranch className="w-10 h-10 text-[#bf5af2]" />
          </div>
          <p className="text-white text-lg font-medium mb-2">No mappings yet</p>
          <p className="text-[#6e6e73]">Upload a file for NLP mapping</p>
        </div>
      </div>
    )
  }
  
  const { mappings, confidence } = mappingResult
  const avgConfidence = Math.round(confidence * 100)
  const displayMappings = compact ? mappings.slice(0, 5) : mappings.slice(0, 8)
  
  return (
    <div className="card p-8">
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-white font-semibold text-lg flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-[#bf5af2] to-[#da8fff] flex items-center justify-center">
            <GitBranch className="w-5 h-5 text-white" />
          </div>
          Schema Mapping
        </h3>
        <div className="flex items-center gap-2 px-4 py-2 rounded-full bg-[#bf5af2]/10">
          <Sparkles className="w-4 h-4 text-[#bf5af2]" />
          <span className="text-[#bf5af2] font-semibold">{avgConfidence}%</span>
        </div>
      </div>
      
      <div className="space-y-3">
        {displayMappings.map((mapping, idx) => (
          <motion.div 
            key={idx}
            initial={{ opacity: 0, x: -10 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: idx * 0.05 }}
            className="flex items-center gap-4 p-4 bg-white/5 rounded-2xl hover:bg-white/8 transition-colors group"
          >
            <code className="text-[#ff9f0a] text-sm bg-[#ff9f0a]/10 px-3 py-1.5 rounded-lg font-mono">
              {mapping.original}
            </code>
            <div className="flex items-center gap-2 flex-shrink-0">
              <div className="w-8 h-[2px] bg-gradient-to-r from-[#2997ff] to-[#bf5af2] rounded-full" />
              <ArrowRight className="w-4 h-4 text-[#bf5af2]" />
            </div>
            <code className="text-[#30d158] text-sm bg-[#30d158]/10 px-3 py-1.5 rounded-lg font-mono">
              {mapping.mapped}
            </code>
            <div className="ml-auto w-7 h-7 rounded-full bg-[#30d158]/20 flex items-center justify-center flex-shrink-0 opacity-0 group-hover:opacity-100 transition-opacity">
              <Check className="w-4 h-4 text-[#30d158]" />
            </div>
          </motion.div>
        ))}
        
        {mappings.length > displayMappings.length && (
          <p className="text-center text-[#6e6e73] text-sm py-3">
            + {mappings.length - displayMappings.length} more mappings
          </p>
        )}
      </div>
    </div>
  )
}
