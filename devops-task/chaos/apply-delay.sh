#!/bin/bash
echo "=== Демонстрация работы ДО внесения задержки ==="
kubectl run -it --rm test-pod --image=curlimages/curl --restart=Never -- curl -s -o /dev/null -w "Время ответа: %{time_total}s\n" http://hello-world.test-app.svc.cluster.local

echo "=== Пауза 5 секунд. Проверьте работу приложения ==="
sleep 5

echo "=== Применяем задержку (3 секунды в 50% запросов) ==="
kubectl apply -f scenario-delay.yaml

echo "=== Демонстрация работы ПОСЛЕ внесения задержки ==="
kubectl run -it --rm test-pod --image=curlimages/curl --restart=Never -- curl -s -o /dev/null -w "Время ответа: %{time_total}s\n" http://hello-world.test-app.svc.cluster.local

echo "=== Пауза 5 секунд. Проверьте, как изменилось время ответа ==="
sleep 5

echo "=== Откатываем изменения ==="
kubectl delete -f scenario-delay.yaml
echo "=== Задержка отменена ==="