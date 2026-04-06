import { motion } from 'framer-motion'
import { FileUp, Table, AlertTriangle, Sparkles } from 'lucide-react'
import { useMigration } from '../context/MigrationContext'

const MetricCard = ({ icon: Icon, label, value, suffix = '', color, delay }) => (
  <motion.div 
    initial={{ opacity: 0, y: 20 }}
    animate={{ opacity: 1, y: 0 }}
    transition={{ delay, duration: 0.5 }}
    className="card p-6 hover-lift"
  >
    <div className="flex items-start justify-between">
      <div>
        <p className="text-[#6e6e73] text-sm mb-2">{label}</p>
        <div className="flex items-baseline gap-1">
          <span className="text-4xl font-semibold text-white tracking-tight">
            {value}
          </span>
          {suffix && <span className="text-lg text-[#86868b]">{suffix}</span>}
        </div>
      </div>
      <div className={`w-12 h-12 rounded-2xl bg-gradient-to-br ${color} flex items-center justify-center shadow-lg`}>
        <Icon className="w-5 h-5 text-white" />
      </div>
    </div>
  </motion.div>
)

export default function StatsCards() {
  const { stats } = useMigration()
  
  const metrics = [
    { 
      icon: FileUp, 
      label: 'Files Processed', 
      value: stats.filesProcessed,
      color: 'from-[#2997ff] to-[#64d2ff]'
    },
    { 
      icon: Table, 
      label: 'Tables Generated', 
      value: stats.tablesGenerated,
      color: 'from-[#30d158] to-[#63e6be]'
    },
    { 
      icon: AlertTriangle, 
      label: 'Anomalies Found', 
      value: stats.anomaliesFound,
      color: 'from-[#ff9f0a] to-[#ffcc00]'
    },
    { 
      icon: Sparkles, 
      label: 'NLP Confidence', 
      value: stats.confidence,
      suffix: '%',
      color: 'from-[#bf5af2] to-[#da8fff]'
    },
  ]
  
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
      {metrics.map((metric, index) => (
        <MetricCard key={metric.label} {...metric} delay={index * 0.1} />
      ))}
    </div>
  )
}
