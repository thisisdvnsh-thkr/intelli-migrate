import { NavLink, useLocation, Link } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { motion } from 'framer-motion'
import { 
  LayoutDashboard, 
  Upload, 
  GitBranch, 
  AlertTriangle, 
  Database,
  Cloud,
  LogOut,
  Zap,
  Settings as SettingsIcon,
  HelpCircle
} from 'lucide-react'

const navItems = [
  { path: '/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
  { path: '/upload', icon: Upload, label: 'Upload' },
  { path: '/schema-map', icon: GitBranch, label: 'Schema Map' },
  { path: '/anomalies', icon: AlertTriangle, label: 'Anomalies' },
  { path: '/generate-sql', icon: Database, label: 'SQL Output' },
  { path: '/deploy', icon: Cloud, label: 'Deploy' },
]

export default function Sidebar() {
  const location = useLocation()
  const { user, logout } = useAuth()
  
  return (
    <aside className="fixed left-0 top-0 bottom-0 w-72 bg-black/40 backdrop-blur-2xl border-r border-white/[0.08] flex flex-col z-50">
      {/* Logo */}
      <div className="px-6 py-8">
        <Link to="/" className="flex items-center gap-3 group">
          <div className="w-11 h-11 rounded-2xl bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center shadow-lg shadow-blue-500/25 group-hover:scale-105 transition-transform duration-300">
            <Zap className="w-5 h-5 text-white" />
          </div>
          <div>
            <h1 className="text-lg font-black text-white tracking-tight">Intelli-Migrate</h1>
            <p className="text-xs text-white/40 font-medium">AI Migration Platform</p>
          </div>
        </Link>
      </div>
      
      {/* Navigation */}
      <nav className="flex-1 px-4 py-2">
        <p className="px-4 py-2 text-xs font-semibold text-white/30 uppercase tracking-wider">Main</p>
        <ul className="space-y-1">
          {navItems.map((item) => {
            const Icon = item.icon
            const isActive = location.pathname === item.path
            
            return (
              <li key={item.path}>
                <NavLink
                  to={item.path}
                  className={`
                    relative flex items-center gap-3 px-4 py-3 rounded-2xl text-sm font-medium
                    transition-all duration-300 group
                    ${isActive 
                      ? 'text-white bg-white/10' 
                      : 'text-white/50 hover:text-white hover:bg-white/5'
                    }
                  `}
                >
                  {isActive && (
                    <motion.div
                      layoutId="activeTab"
                      className="absolute left-0 top-1/2 -translate-y-1/2 w-1 h-6 bg-blue-500 rounded-full"
                      transition={{ type: "spring", stiffness: 500, damping: 30 }}
                    />
                  )}
                  <Icon className={`w-5 h-5 ${isActive ? 'text-blue-400' : ''}`} strokeWidth={1.5} />
                  <span>{item.label}</span>
                </NavLink>
              </li>
            )
          })}
        </ul>
        
        <div className="mt-8">
          <p className="px-4 py-2 text-xs font-semibold text-white/30 uppercase tracking-wider">Support</p>
          <ul className="space-y-1">
            <li>
              <NavLink 
                to="/help" 
                className={({ isActive }) => `flex items-center gap-3 px-4 py-3 rounded-2xl text-sm font-medium transition-all duration-300 ${
                  isActive ? 'text-white bg-white/10' : 'text-white/50 hover:text-white hover:bg-white/5'
                }`}
              >
                <HelpCircle className="w-5 h-5" strokeWidth={1.5} />
                <span>Help Center</span>
              </NavLink>
            </li>
            <li>
              <NavLink 
                to="/settings" 
                className={({ isActive }) => `flex items-center gap-3 px-4 py-3 rounded-2xl text-sm font-medium transition-all duration-300 ${
                  isActive ? 'text-white bg-white/10' : 'text-white/50 hover:text-white hover:bg-white/5'
                }`}
              >
                <SettingsIcon className="w-5 h-5" strokeWidth={1.5} />
                <span>Settings</span>
              </NavLink>
            </li>
          </ul>
        </div>
      </nav>
      
      {/* User Section */}
      <div className="px-4 py-6 border-t border-white/[0.08]">
        {user ? (
          <div className="space-y-3">
            <div className="flex items-center gap-3 px-3">
              <div className="w-9 h-9 rounded-xl bg-gradient-to-br from-purple-500 to-pink-500 flex items-center justify-center text-white font-bold text-sm">
                {user.name?.charAt(0).toUpperCase() || 'U'}
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-sm font-semibold text-white truncate">{user.name || 'User'}</p>
                <p className="text-xs text-white/40 truncate">{user.email}</p>
              </div>
            </div>
            <button
              onClick={logout}
              className="flex items-center gap-3 w-full px-4 py-3 text-sm font-medium text-white/50 hover:text-red-400 rounded-2xl hover:bg-red-500/10 transition-all duration-300"
            >
              <LogOut className="w-4 h-4" />
              <span>Sign Out</span>
            </button>
          </div>
        ) : (
          <Link
            to="/login"
            className="flex items-center justify-center w-full py-3 text-sm font-bold bg-white text-black rounded-2xl hover:bg-white/90 hover:scale-[1.02] transition-all duration-300"
          >
            Sign In
          </Link>
        )}
      </div>
    </aside>
  )
}