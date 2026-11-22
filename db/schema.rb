# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_21_235000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "consentimento_lgpd", force: :cascade do |t|
    t.integer "id_pessoa"
    t.string "aceite"
    t.date "data_aceite"
    t.string "versao_termo"
    t.boolean "revogado"
    t.date "data_revogado"
  end

  create_table "documentos", force: :cascade do |t|
    t.integer "id_pessoa"
    t.string "tipo_documento"
    t.string "nome_arquivo"
    t.date "data_upload"
    t.string "status_analise"
    t.string "observacao"
  end

  create_table "encontro", force: :cascade do |t|
    t.integer "id_turma"
    t.date "data_encontro"
    t.string "tema"
    t.string "descricao"
  end

  create_table "matricula", force: :cascade do |t|
    t.integer "id_pessoa"
    t.string "id_turma"
    t.date "data_matricula"
    t.string "status"
    t.string "observacao"
  end

  create_table "mural_aviso", force: :cascade do |t|
    t.integer "id_pessoa"
    t.string "titulo"
    t.string "conteudo"
    t.date "data_publicacao"
    t.boolean "ativo"
    t.string "observacao"
  end

  create_table "perfils", force: :cascade do |t|
    t.string "nome"
  end

  create_table "pessoa_perfils", force: :cascade do |t|
    t.integer "id_pessoa"
    t.integer "id_perfil"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "senha_hash"
    t.string "telefone"
    t.boolean "ativo", default: true
    t.date "data_cadastro"
    t.string "observacao"
    t.string "provider"
    t.string "uid"
    t.index ["provider", "uid"], name: "index_pessoas_on_provider_and_uid", unique: true
  end

  create_table "presenca", force: :cascade do |t|
    t.integer "id_encontro"
    t.integer "id_matricula"
    t.boolean "presente"
    t.string "observacao"
  end

  create_table "relatorios", force: :cascade do |t|
    t.string "id_pessoa"
    t.string "tipo"
    t.string "parametros"
    t.date "data_geracao"
    t.string "formato"
    t.string "url_arquivo"
    t.string "observacao"
  end

  create_table "responsavel_alunos", force: :cascade do |t|
    t.integer "id_aluno"
    t.integer "id_responsavel"
    t.string "principal"
  end

  create_table "turma", force: :cascade do |t|
    t.integer "id_turma"
    t.string "nome"
    t.string "descricao"
    t.string "fase"
    t.string "dia_semana"
    t.string "horario_inicio"
    t.string "horario_fim"
    t.integer "vagas"
    t.string "status"
    t.integer "id_catequista"
  end
end
