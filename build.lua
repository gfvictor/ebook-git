local vol = arg[1]

if not vol then
	print("Para compilar, use 'lua build-mobile.lua <numero-do-volume>'")
	os.exit(1)
end

local folder = "volume-" .. vol
local output = "output/git-volume-" .. vol .. ".pdf"
os.execute("mkdir -p output")

local function file_exists(path)
  local f = io.open(path, "r")
  if f then f:close(); return true else return false end
end

local files = {
  "shared/base_style.yaml",
  folder .. "/metadata.yaml",
  folder .. "/pre-textual.md"
}

local optionals = {
  folder .. "/capitulo*.md",
  folder .. "/bonus.md",
  folder .. "referencias.md"
}

for _, pattern in ipairs(optionals) do
  if pattern:find("*") or file_exists (pattern) then
    table.insert(files, pattern)
  end
end

local cmd = "pandoc " .. table.concat(files, " ") .. " -o " .. output .. " --pdf-engine=tectonic"

print("-- Compilando Volume " .. vol .. ", aguarde...")
local status = os.execute(cmd)

if status then
	print("-- PDF gerado com sucesso: " .. output)
else
	print("-- Erro na compilação.")
end
