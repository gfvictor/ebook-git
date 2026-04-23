local vol = arg[1]

if not vol then
	print("Use 'lua build.lua <numero-do-volume>'")
	os.exit(1)
end

local folder = "volume-" .. vol
local output = "output/git-volume-" .. vol .. ".pdf"

os.execute("mkdir -p output")

local cmd = string.format(
	"pandoc shared/base_style.yaml %s/metadata.yaml %s/pre-textual.md %s/capitulo*.md %s/capitulo-bonus.md %s/referencias.md -o %s --pdf-engine=tectonic", folder, folder, folder, folder, folder, output
)
print("Compilando Volume " .. vol .. ", aguarde...")

local status = os.execute(cmd)

if status then
	print("PDF gerado com sucesso: " .. output)
else
	print("Erro na compilação.")
end
