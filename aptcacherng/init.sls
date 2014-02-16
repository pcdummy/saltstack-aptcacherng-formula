{% from "aptcacherng/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('aptcacherng:lookup')) %}

aptcacherng:
  pkg:
    - installed
    - pkgs:
{% for p in datamap['pkgs'] %}
      - {{ p }}
{% endfor %}
  service:
    - running
    - name: {{ datamap['service']['name'] }}
    - enable: {{ datamap['service']['enable'] }}
    - require:
      - pkg: aptcacherng
