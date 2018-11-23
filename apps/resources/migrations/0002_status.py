# -*- coding: utf-8 -*-
# Generated by Django 1.11.8 on 2018-10-12 09:56
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('resources', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Status',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=10, unique=True, verbose_name='状态名')),
            ],
            options={
                'db_table': 'resources_status',
            },
        ),
    ]
