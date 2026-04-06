import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://bmrdthnptzazsuoznhto.supabase.co'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJtcmR0aG5wdHphenN1b3puaHRvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMzgwODksImV4cCI6MjA5MDgxNDA4OX0.j-qA4K0dc2flnK43TvGrTtiLwvpYa6waERLtKxAQDOs'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Auth helpers
export const signUp = async (email, password, fullName) => {
  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      data: { full_name: fullName }
    }
  })
  if (error) throw error
  return data
}

export const signIn = async (email, password) => {
  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password
  })
  if (error) throw error
  return data
}

export const signOut = async () => {
  const { error } = await supabase.auth.signOut()
  if (error) throw error
}

export const getCurrentUser = async () => {
  const { data: { user } } = await supabase.auth.getUser()
  return user
}

// Migration session helpers
export const saveMigration = async (migrationData) => {
  const { data: { user } } = await supabase.auth.getUser()
  
  const { data, error } = await supabase
    .from('migrations')
    .insert([{
      user_id: user?.id,
      ...migrationData
    }])
    .select()
  
  if (error) throw error
  return data[0]
}

export const getMigrations = async () => {
  const { data, error } = await supabase
    .from('migrations')
    .select('*')
    .order('created_at', { ascending: false })
    .limit(10)
  
  if (error) throw error
  return data || []
}
