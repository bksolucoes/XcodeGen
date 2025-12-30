# AlongueJá — Projeto Xcode (gerar localmente)

Este diretório contém todo o código-fonte e um arquivo `project.yml` para gerar um .xcodeproj com o utilitário `xcodegen`. Também há um script `setup_assets.sh` que cria um `Assets.xcassets` com imagens de exemplo (placeholders) que você pode substituir.

Requisitos
- macOS com Xcode instalado (recomendado >= 14).
- Homebrew (opcional, para instalar xcodegen).
- xcodegen (recomendado) — instala com: `brew install xcodegen`

Instruções — gerar projeto com xcodegen (recomendado)
1. Abra o Terminal e vá para a pasta que contém estes arquivos (onde está `project.yml`).
2. Torne o script executável e gere assets:
   - chmod +x setup_assets.sh
   - ./setup_assets.sh
3. Gere o Xcode project:
   - xcodegen generate
   Isso criará `AlongueJa.xcodeproj` (nome baseado no `project.yml`).
4. Abra no Xcode:
   - open AlongueJa.xcodeproj
5. Ajuste o Team em Signing & Capabilities, selecione um dispositivo/simulador e rode.

Como editar/atualizar assets
- `setup_assets.sh` criou placeholders 1x1 transparentes em:
  StretchApp/Assets.xcassets/Shoulder.imageset/Shoulder.png
  StretchApp/Assets.xcassets/Neck.imageset/Neck.png
  StretchApp/Assets.xcassets/Calf.imageset/Calf.png
- No Xcode: abra `Assets.xcassets`, substitua os placeholders por imagens reais (PNG/PDF) ou GIFs (para GIFs, coloque como "Data" resource ou use imagens animadas via UIImage. Note que Asset Catalog não suporta GIF animado nativamente; importe como Data asset ou use um arquivo .gif no bundle e carregue com UIImage).

Instruções alternativas — sem xcodegen (manualmente)
1. Abra Xcode -> Create New Project -> App (SwiftUI).
2. Nomeie o projeto "AlongueJa", bundle id `com.bksolucoes.AlongueJa`.
3. Apague os arquivos gerados e adicione os arquivos Swift deste diretório (copie para o projeto).
4. Adicione um Assets Catalog chamado `Assets.xcassets` e importe os arquivos .png gerados pelo `setup_assets.sh` (ou arraste suas imagens).
5. Ajuste Info.plist/Signing se necessário e rode.

Notas sobre GIFs/Animações
- Asset Catalog não reproduz GIFs animados automaticamente em Image views — para GIFs animados, coloque o arquivo .gif no bundle e use uma biblioteca (ex: `SDWebImageSwiftUI`) ou implemente `UIImage.animatedImage...` para exibir animação.
- Para ilustrações vetoriais, importe PDF (single scale) no asset catalog e marque como "Preserve Vector Data".

Próximos passos sugeridos
- Substituir placeholders por imagens reais (fotos ou ilustrações).
- Adicionar persistência (UserDefaults/CoreData) para salvar rotinas criadas/editar.
- Incluir Widgets (WidgetKit) e integração com HealthKit/Health.

Se quiser, eu:
- Posso gerar arquivos .gif ou imagens PNG de exemplo (maiores e coloridas) e incluir base64 aqui para você salvar automaticamente.
- Posso gerar um .zip pronto (preciso te orientar como baixar; aqui não consigo enviar binários diretamente).
- Posso adaptar o project.yml (bundle id, deployment target) para suas preferências — me diga bundle id e versão mínima iOS.