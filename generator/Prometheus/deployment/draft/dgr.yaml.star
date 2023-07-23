apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
  namespace: monitoring
  labels:
    app: prometheus
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prometheus
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  revisionHistoryLimit: 2
  template:
    metadata:
      labels: 
        app: prometheus
    spec:
      initContainers:
        - name: prom-busy-bos-set-permis
          image: busybox
          command: ["/bin/chmod","-R","777","/prometheus"]
          volumeMounts: 
          - name: prometheus-storage
            mountPath: /prometheus
      containers:
      - name: prometheus
        image: prom/prometheus:v2.44.0
        command: 
        args:
            - "--storage.tsdb.retention=6h"
            - "--storage.tsdb.path=/prometheus"
            - "--config.file=/etc/prometheus/prometheus.yml"
        ports:
        - containerPort: 9090
          hostIP: 
          name: promport
          protocol: 
        volumeMounts:
        - name: prometheus-config
          mountPath: /etc/prometheus
        - name: prometheus-storage
          mountPath: /prometheus
      volumes:
      - name: prometheus-storage
        persistentVolumeClaim:
          claimName: pvc1-data
      - name: prometheus-config 
        configMap:
          name: prometheus-config
          defaultMode: 420
