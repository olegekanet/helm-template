{{/*
Expand the name of the chart.
*/}}
{{- define "helm-template.name" -}}
{{- if .Chart -}}
{{ .Values.Name }}
{{- else -}}
default-chart-name
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm-template.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Values.Name .Values.nameOverride }}
{{- if contains $name .Values.Name }}
{{- .Values.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Values.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm-template.chart" -}}
{{- printf "%s-%s" .Values.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "helm-template.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm-template.name" . }}
app.kubernetes.io/instance: {{ .Values.Name | default "default-instance" }}  # Use a default value if nil
{{- if .Chart -}}
chart: {{ .Values.Name | default "default-chart" }}  # Use a default value if nil
{{- end -}}
{{- end }}

{{/*
Create the name of the service account to use.
*/}}
{{- define "helm-template.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "helm-template.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}