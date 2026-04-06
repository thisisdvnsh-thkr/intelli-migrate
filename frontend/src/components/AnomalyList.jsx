import { motion } from 'framer-motion'
import { AlertTriangle, CheckCircle, X, Shield } from 'lucide-react'
import { useMigration } from '../context/MigrationContext'

export default function AnomalyList({ compact = false }) {
  const { anomalyResult } = useMigration()
  
  if (!anomalyResult?.anomalies?.length) {
    return (
      <div className="card p-8">
        <h3 className="text-white font-semibold text-lg mb-6 flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-[#ff9f0a] to-[#ffcc00] flex items-center justify-center">
            <AlertTriangle className="w-5 h-5 text-white" />
          </div>
          Anomalies Detected
        </h3>
        <div className="text-center py-12">
          <div className="w-20 h-20 mx-auto mb-6 rounded-full bg-[#30d158]/10 flex items-center justify-center">
            <CheckCircle className="w-10 h-10 text-[#30d158]" />
          </div>
          <p className="text-white text-lg font-medium mb-2">No anomalies detected</p>
          <p className="text-[#6e6e73]">Upload a file to scan for issues</p>
        </div>
      </div>
    )
  }
  
  const { anomalies, quality_score, records_removed, total_records } = anomalyResult
  const qualityPercent = Math.round(quality_score * 100)
  const displayAnomalies = compact ? anomalies.slice(0, 5) : anomalies.slice(0, 10)
  
  const getTypeStyle = (type) => {
    switch (type) {
      case 'missing_value': return { color: 'text-[#ff9f0a]', bg: 'bg-[#ff9f0a]/10' }
      case 'outlier': return { color: 'text-[#ff453a]', bg: 'bg-[#ff453a]/10' }
      case 'invalid_format': return { color: 'text-[#bf5af2]', bg: 'bg-[#bf5af2]/10' }
      case 'duplicate': return { color: 'text-[#2997ff]', bg: 'bg-[#2997ff]/10' }
      default: return { color: 'text-[#6e6e73]', bg: 'bg-[#6e6e73]/10' }
    }
  }
  
  return (
    <div className="card p-8">
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-white font-semibold text-lg flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-[#ff9f0a] to-[#ffcc00] flex items-center justify-center">
            <AlertTriangle className="w-5 h-5 text-white" />
          </div>
          Records Flagged
        </h3>
        <div className="flex items-center gap-6">
          <div className="text-right">
            <p className="text-[10px] text-[#6e6e73] uppercase tracking-wider">Quality</p>
            <p className={`text-lg font-semibold ${
              qualityPercent >= 80 ? 'text-[#30d158]' : 
              qualityPercent >= 60 ? 'text-[#ff9f0a]' : 
              'text-[#ff453a]'
            }`}>
              {qualityPercent}%
            </p>
          </div>
          <div className="text-right">
            <p className="text-[10px] text-[#6e6e73] uppercase tracking-wider">Flagged</p>
            <p className="text-lg font-semibold text-white">{records_removed}/{total_records}</p>
          </div>
        </div>
      </div>
      
      <div className="space-y-2 max-h-80 overflow-y-auto">
        {displayAnomalies.map((anomaly, idx) => {
          const style = getTypeStyle(anomaly.type)
          return (
            <motion.div 
              key={idx}
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: idx * 0.03 }}
              className="flex items-center justify-between p-4 bg-white/5 rounded-2xl hover:bg-white/8 transition-colors"
            >
              <div className="flex items-center gap-3">
                <div className="w-9 h-9 rounded-xl bg-[#ff453a]/10 flex items-center justify-center flex-shrink-0">
                  <X className="w-4 h-4 text-[#ff453a]" />
                </div>
                <div className="min-w-0">
                  <p className="text-white text-sm font-medium truncate">
                    Row {anomaly.row_index + 1}: {anomaly.column}
                  </p>
                  <p className="text-[#6e6e73] text-xs truncate">{anomaly.reason}</p>
                </div>
              </div>
              <span className={`px-3 py-1.5 rounded-full text-xs font-medium flex-shrink-0 ${style.color} ${style.bg}`}>
                {anomaly.type.replace('_', ' ')}
              </span>
            </motion.div>
          )
        })}
        
        {anomalies.length > displayAnomalies.length && (
          <p className="text-center text-[#6e6e73] text-sm py-3">
            + {anomalies.length - displayAnomalies.length} more
          </p>
        )}
      </div>
    </div>
  )
}
