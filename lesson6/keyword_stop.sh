#!/bin/bash
kill $(ps aux | grep keyword | awk '{print $2}')
