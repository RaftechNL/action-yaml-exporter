# action-yaml-exporter

![Logo](https://img.raftech.nl/white_logo_color1_background.png)

Github Action allowing for dynamic & path based export of properties from YAML files using YQ under the hood.

## inputs

| Key                  | Description                               | Required | Default Value |
| -------------------- | ----------------------------------------- | -------- | ------------- |
| source-file          | Path to file to be used as source         | true     | N/A           |
| yaml-properties      | YAML properties to be exported            | true     | N/A           |
| export-to-ci-env     | Export to environment variables in the CI | false    | "false"       |
| export-to-ci-outputs | Export to action outputs in the CI        | false    | "false"       |
| export-to-env-file   | Export to env file                        | false    | "false"       |
| prefix               | Prefix to be used for the exported values | false    | ""            |
| env-file             | Path/Name of the env file to be created   | false    | "env.export"  |



## Usage/Examples

```yaml
jobs:    
  export-from-yaml:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: "Export from YAML"
        uses: RaftechNL/action-yaml-exporter@v1.0.0
        id: export-to-yaml
        with:
          source-file: .cicd/metadata.yaml
          export-to-ci-env: "true"
          export-to-ci-outputs: "true"
          export-to-env-file: "true"
          prefix: "SSM_"
          yaml-properties: |
            APP_NAME=.app.name
            APP_STAGE=.app.brand

      - name: "show output"
        run: |
          echo "app name: ${{ steps.export-to-yaml.outputs.APP_NAME }}"            
          echo "stage: ${{ steps.export-to-yaml.outputs.APP_STAGE }}"        

          echo "app name: ${{ env.SSM_APP_NAME }}"            
          echo "stage: ${{ env.SSM_APP_STAGE }}"              

          cat env.export     
```

## License
[![License](https://img.shields.io/github/license/raftechnl/action-yaml-exporter)](./LICENSE)
                |
## Contributing

Contributions are always welcome!

## Authors

- [@rafpe](https://www.github.com/rafpe)
