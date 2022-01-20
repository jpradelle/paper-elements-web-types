#!/bin/bash

IFS=$'\n'
declare -A variables
declare -A descriptions
declare -A defaultValues

# Find variables from documentations
docRegex='`(--[a-zA-Z0-9-]+)`\s*\|([^\|]+)\|\s*`([^`]+)`'
for match in $(grep -rho -E $docRegex --include "*.d.ts"  --exclude-dir 'test' node_modules/@polymer/)
do
	if [[ $match =~ $docRegex ]]
	then
		variables[${BASH_REMATCH[1]}]=true
		descriptions[${BASH_REMATCH[1]}]=$(echo ${BASH_REMATCH[2]} | xargs)
		defaultValues[${BASH_REMATCH[1]}]=${BASH_REMATCH[3]}
	fi
done

# Find variables from css definitions
cssRegex='(--[a-zA-Z0-9-]+)\s*:\s*([^;]+);'
for match in $(grep -rho -E $cssRegex  --include "*.js" --exclude-dir 'test' node_modules/@polymer/)
do
	if [[ $match =~ $cssRegex ]]
	then
		variables[${BASH_REMATCH[1]}]=true
		if [[ ${defaultValues[${BASH_REMATCH[1]}]} == '' && ${descriptions[${BASH_REMATCH[1]}]} == '' ]]
		then
			defaultValues[${BASH_REMATCH[1]}]=${BASH_REMATCH[2]}
		fi
	fi
done

# Build json
first=true
build=""
lineReturn='
'
for key in "${!variables[@]}"
do
	if [[ $first == true ]]
	then
		first=false
	else
		build="$build,$lineReturn"
	fi
	build="$build{\"name\":\"$key\", \"descriptions\":\"${descriptions[$key]}\", \"values\":[\"${defaultValues[$key]}\"], \"priority\": \"low\"}"
done

cat > src/gen/paper-elements-template-css-web-types.json <<__EOF__
{
  "\$schema": "http://json.schemastore.org/web-types",
  "name": "paper-elements-css-web-types",
  "version": "",
  "default-icon": "icon/polymer.png",
  "description-markup": "markdown",
  "framework": "",
  "contributions": {
    "css": {
      "properties": [
        $build
      ]
    }
  }
}
__EOF__
