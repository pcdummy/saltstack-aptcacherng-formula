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

{% set id = 0 %}
{% for v in salt['pillar.get']('aptcacherng:configs', {}) %}
aptcacherng_conf_{{ v['file'] }}:
  file:
    - managed
    - name: {{ datamap.conf_dir|default('/etc/apt-cacher-ng') }}/{{ v['file'] }}
    - mode: 644
    - user: root
    - group: root
    - contents_pillar: aptcacherng:configs:{{ id }}:content
    - watch_in:
      - service: aptcacherng
{%- set id = id + 1 %}
{% endfor %}
