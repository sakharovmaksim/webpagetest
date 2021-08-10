# webpagetest-prometheus-exporter
> A runner that periodically tests a url with [webpagetest.org](https://www.webpagetest.org) and exposes those values to [prometheus.io](https://prometheus.io)

## Gettings Started
1. Exec `docker-compose -f docker-compose.dev.yml up --build --force-recreate`
2. Create a config and check out the [sample-config.toml](./config-dev.toml):

```toml
# the Key from your local or remote webpagetest instance
key = "123"
# the URL to your webpagetest instance, if you run locally (and on a mac, use your real ip)
host = "http://127.0.0.1:4000"
# the Port where the service is running and the metrics are exposed
port = "3030"
# How often do you want to run the test
timer = "1h"

# An array of metrics you want to expose with prometheus
[[metrics]]
key = "time_to_first_byte_ms"
# Prometheus help
help = "First Byte in ms."
# The Data from the reponse that gets collected, the array index is set as run
data = [
    "median.firstView.TTFB",
]

# An Array of sites / urls you want to tests
[[sites]]
name = "asna main"
url = "https://www.asna.ru"
location = "Test.LAN"
```

3. Check the output at [http://localhost:3030](http://localhost:3030)

4. Add to Prometheus to scrape

### Sample metrics

```text
# HELP page_requests_no Page Size
# TYPE page_requests_no gauge
page_requests_no{location="Test",run="1",url="https://www.bbc.co.uk"} 81
page_requests_no{location="Test",run="2",url="https://www.bbc.co.uk"} 7

# HELP page_size_bytes Page Size
# TYPE page_size_bytes gauge
page_size_bytes{location="Test",run="1",url="https://www.bbc.co.uk"} 49001
page_size_bytes{location="Test",run="2",url="https://www.bbc.co.uk"} 112527

# HELP speed_index_no Speed Index
# TYPE speed_index_no gauge
speed_index_no{location="Test",run="1",url="https://www.bbc.co.uk"} 1617
speed_index_no{location="Test",run="2",url="https://www.bbc.co.uk"} 1102

# HELP time_first_byte First Byte in ms.
# TYPE time_first_byte gauge
time_first_byte{location="Test",run="1",url="https://www.bbc.co.uk"} 138
time_first_byte{location="Test",run="2",url="https://www.bbc.co.uk"} 121

# HELP time_load_time Load time in ms.
# TYPE time_load_time gauge
time_load_time{location="Test",run="1",url="https://www.bbc.co.uk"} 1657
time_load_time{location="Test",run="2",url="https://www.bbc.co.uk"} 1163

# HELP time_start_render_ms Start render time.
# TYPE time_start_render_ms gauge
time_start_render_ms{location="Test",run="1",url="https://www.bbc.co.uk"} 500
time_start_render_ms{location="Test",run="2",url="https://www.bbc.co.uk"} 300

# HELP time_visually_complete_ms Visually Complete
# TYPE time_visually_complete_ms gauge
time_visually_complete_ms{location="Test",run="1",url="https://www.bbc.co.uk"} 2400
time_visually_complete_ms{location="Test",run="2",url="https://www.bbc.co.uk"} 1600
```
