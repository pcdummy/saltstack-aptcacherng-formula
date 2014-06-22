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

{% if 'acng_conf' in datamap.config.manage|default([]) %}
acng_conf:
  file:
    - managed
    - name: {{ datamap.config.acng_conf.path|default('/etc/apt-cacher-ng/acng.conf') }}
    - source: {{ datamap.config.acng_conf.template_path|default('salt://aptcacherng/files/acng.conf') }}
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - watch_in:
      - service: aptcacherng
{% endif %}
