import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom'
import { AuthProvider } from './context/AuthContext'
import { MigrationProvider } from './context/MigrationContext'
import { AnimatePresence, motion } from 'framer-motion'
import Sidebar from './components/Sidebar'
import Dashboard from './pages/Dashboard'
import Upload from './pages/Upload'
import SchemaMap from './pages/SchemaMap'
import Anomalies from './pages/Anomalies'
import GenerateSQL from './pages/GenerateSQL'
import Deploy from './pages/Deploy'
import Login from './pages/Login'
import Signup from './pages/Signup'
import Landing from './pages/Landing'
import Settings from './pages/Settings'
import Help from './pages/Help'

// Page transition wrapper
function PageTransition({ children }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.3, ease: 'easeInOut' }}
    >
      {children}
    </motion.div>
  )
}

// Layout with sidebar for dashboard pages
function DashboardLayout({ children }) {
  return (
    <div className="flex min-h-screen bg-[#0a0a0b]">
      <Sidebar />
      <main className="flex-1 ml-72 min-h-screen">
        <div className="max-w-7xl mx-auto px-8 py-8">
          <PageTransition>{children}</PageTransition>
        </div>
      </main>
    </div>
  )
}

// Full-width layout for public pages
function PublicLayout({ children }) {
  return (
    <div className="min-h-screen bg-black">
      <PageTransition>{children}</PageTransition>
    </div>
  )
}

function AppRoutes() {
  const location = useLocation()
  
  // Public routes (no sidebar)
  const publicRoutes = ['/', '/login', '/signup']
  const isPublicRoute = publicRoutes.includes(location.pathname)
  
  return (
    <AnimatePresence mode="wait">
      <Routes location={location} key={location.pathname}>
        {/* Public Routes */}
        <Route path="/" element={<PublicLayout><Landing /></PublicLayout>} />
        <Route path="/login" element={<PublicLayout><Login /></PublicLayout>} />
        <Route path="/signup" element={<PublicLayout><Signup /></PublicLayout>} />
        
        {/* Dashboard Routes */}
        <Route path="/dashboard" element={<DashboardLayout><Dashboard /></DashboardLayout>} />
        <Route path="/upload" element={<DashboardLayout><Upload /></DashboardLayout>} />
        <Route path="/schema-map" element={<DashboardLayout><SchemaMap /></DashboardLayout>} />
        <Route path="/anomalies" element={<DashboardLayout><Anomalies /></DashboardLayout>} />
        <Route path="/generate-sql" element={<DashboardLayout><GenerateSQL /></DashboardLayout>} />
        <Route path="/deploy" element={<DashboardLayout><Deploy /></DashboardLayout>} />
        <Route path="/settings" element={<DashboardLayout><Settings /></DashboardLayout>} />
        <Route path="/help" element={<DashboardLayout><Help /></DashboardLayout>} />
      </Routes>
    </AnimatePresence>
  )
}

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <MigrationProvider>
          <AppRoutes />
        </MigrationProvider>
      </AuthProvider>
    </BrowserRouter>
  )
}