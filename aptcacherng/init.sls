#!jinja|yaml

{% from "aptcacherng/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('aptcacherng:lookup')) %}

aptcacherng:
  pkg:
    - installed
    - pkgs: {{ datamap.pkgs|default([]) }}
  service:
    - running
    - name: {{ datamap.service.name|default('apt-cacher-ng') }}
    - enable: {{ datamap.service.enable|default(True) }}
    - require:
      - pkg: aptcacherng

{% for k, v in salt['pillar.get']('aptcacherng:configs', {})|dictsort %}
aptcacherng_conf_{{ k }}:
  file:
    - managed
    - name: {{ datamap.conf_dir|default('/etc/apt-cacher-ng') }}/{{ k }}
    - mode: 644
    - user: root
    - group: root
    - contents_pillar: aptcacherng:configs:{{ k }}:content
    - watch_in:
      - service: aptcacherng
{% endfor %}
