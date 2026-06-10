-- Script de Configuração do Banco de Dados para Transito Fácil
-- Execute este script no SQL Editor do seu painel do Supabase (https://supabase.com)

-- 1. Tabela de Questões
CREATE TABLE IF NOT EXISTS public.questions (
    id SERIAL PRIMARY KEY,
    cat TEXT NOT NULL,
    text TEXT NOT NULL,
    opts TEXT[] NOT NULL,
    ans INTEGER NOT NULL,
    exp TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Tabela de Sinais (Placas)
CREATE TABLE IF NOT EXISTS public.sinais_data (
    id TEXT PRIMARY KEY,
    cat TEXT NOT NULL,
    name TEXT NOT NULL,
    "desc" TEXT NOT NULL,
    tipo TEXT NOT NULL,
    svg TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Tabela de Dicas & Macetes
CREATE TABLE IF NOT EXISTS public.dicas (
    id SERIAL PRIMARY KEY,
    icon TEXT NOT NULL,
    title TEXT NOT NULL,
    text TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Tabela de Histórico de Simulados
CREATE TABLE IF NOT EXISTS public.simulados_history (
    id SERIAL PRIMARY KEY,
    user_name TEXT NOT NULL,
    total_questions INTEGER NOT NULL,
    correct_answers INTEGER NOT NULL,
    percentage INTEGER NOT NULL,
    category TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. Tabela de Ranking do Jogo
CREATE TABLE IF NOT EXISTS public.game_leaderboard (
    id SERIAL PRIMARY KEY,
    user_name TEXT NOT NULL,
    score INTEGER NOT NULL,
    level INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Habilitar Row Level Security (RLS) para proteção dos dados
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sinais_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dicas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.simulados_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.game_leaderboard ENABLE ROW LEVEL SECURITY;

-- Criar Políticas de Acesso (Policies)

-- Permissões para public.questions (Leitura pública permitida)
CREATE POLICY "Permitir leitura publica de questoes" 
ON public.questions FOR SELECT USING (true);

-- Permissões para public.sinais_data (Leitura pública permitida)
CREATE POLICY "Permitir leitura publica de sinais" 
ON public.sinais_data FOR SELECT USING (true);

-- Permissões para public.dicas (Leitura pública permitida)
CREATE POLICY "Permitir leitura publica de dicas" 
ON public.dicas FOR SELECT USING (true);

-- Permissões para public.simulados_history (Leitura e inserção públicas permitidas)
CREATE POLICY "Permitir leitura publica de historico" 
ON public.simulados_history FOR SELECT USING (true);

CREATE POLICY "Permitir insercao publica de historico" 
ON public.simulados_history FOR INSERT WITH CHECK (true);

-- Permissões para public.game_leaderboard (Leitura e inserção públicas permitidas)
CREATE POLICY "Permitir leitura publica do ranking" 
ON public.game_leaderboard FOR SELECT USING (true);

CREATE POLICY "Permitir insercao publica no ranking" 
ON public.game_leaderboard FOR INSERT WITH CHECK (true);
