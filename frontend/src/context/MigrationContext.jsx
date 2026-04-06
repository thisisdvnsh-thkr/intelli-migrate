import { createContext, useContext, useState, useCallback } from 'react'

const MigrationContext = createContext(null)

export function MigrationProvider({ children }) {
  const [session, setSession] = useState(null)
  const [currentStep, setCurrentStep] = useState(0)
  const [isProcessing, setIsProcessing] = useState(false)
  const [error, setError] = useState(null)
  
  const [parseResult, setParseResult] = useState(null)
  const [mappingResult, setMappingResult] = useState(null)
  const [anomalyResult, setAnomalyResult] = useState(null)
  const [normalizeResult, setNormalizeResult] = useState(null)
  const [sqlResult, setSqlResult] = useState(null)
  const [deployResult, setDeployResult] = useState(null)
  
  const [stats, setStats] = useState({
    filesProcessed: 0,
    tablesGenerated: 0,
    anomaliesFound: 0,
    confidence: 0,
    recordsProcessed: 0
  })

  const resetSession = useCallback(() => {
    setSession(null)
    setCurrentStep(0)
    setIsProcessing(false)
    setError(null)
    setParseResult(null)
    setMappingResult(null)
    setAnomalyResult(null)
    setNormalizeResult(null)
    setSqlResult(null)
    setDeployResult(null)
    setStats({
      filesProcessed: 0,
      tablesGenerated: 0,
      anomaliesFound: 0,
      confidence: 0,
      recordsProcessed: 0
    })
  }, [])

  const updateStats = useCallback((newStats) => {
    setStats(prev => ({ ...prev, ...newStats }))
  }, [])

  const value = {
    session, setSession,
    currentStep, setCurrentStep,
    isProcessing, setIsProcessing,
    error, setError,
    parseResult, setParseResult,
    mappingResult, setMappingResult,
    anomalyResult, setAnomalyResult,
    normalizeResult, setNormalizeResult,
    sqlResult, setSqlResult,
    deployResult, setDeployResult,
    stats, setStats, updateStats,
    resetSession
  }

  return (
    <MigrationContext.Provider value={value}>
      {children}
    </MigrationContext.Provider>
  )
}

export function useMigration() {
  const context = useContext(MigrationContext)
  if (!context) {
    throw new Error('useMigration must be used within MigrationProvider')
  }
  return context
}
