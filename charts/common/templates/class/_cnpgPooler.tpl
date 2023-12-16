{{- define "tc.v1.common.class.cnpg.pooler" -}}
  {{- $values := .Values.cnpg -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.cnpg -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $cnpgClusterName := $values.name -}}
  {{- $cnpgName := $values.cnpgName -}}
  {{- $cnpgPoolerName := $values.poolerName -}}
  {{- $cnpgClusterLabels := $values.labels -}}
  {{- $cnpgClusterAnnotations := $values.annotations -}}
  {{- $instances := $values.pooler.instances | default 2 -}}
  {{- if or $values.hibernate (include "tc.v1.common.lib.util.stopAll" $) -}}
    {{- $instances = 0 -}}
  {{- end }}
---
apiVersion: {{ include "tc.v1.common.capabilities.cnpg.pooler.apiVersion" $ }}
kind: Pooler
metadata:
  name: {{ printf "%v-%v" $cnpgClusterName $values.pooler.type }}
  namespace: {{ $.Values.namespace | default $.Values.global.namespace | default $.Release.Namespace }}
spec:
  cluster:
    name: {{ $cnpgClusterName }}
  instances: {{ $instances }}
  type: {{ $values.pooler.type }}
  pgbouncer:
    poolMode: session
    parameters:
      max_client_conn: "1000"
      default_pool_size: "10"

{{- end -}}
