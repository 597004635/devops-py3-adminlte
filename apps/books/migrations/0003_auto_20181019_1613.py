# -*- coding: utf-8 -*-
# Generated by Django 1.11.8 on 2018-10-19 16:13
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('books', '0002_auto_20181019_1514'),
    ]

    operations = [
        migrations.AlterField(
            model_name='author',
            name='email',
            field=models.EmailField(max_length=254, null=True, verbose_name='作者邮箱'),
        ),
    ]
