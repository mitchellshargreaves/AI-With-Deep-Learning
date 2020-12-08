#!/bin/bash
pandoc  --metadata-file=hpc_ai_vars.yml --template hpc_ai.md hpc_ai.md | pandoc -s - -t slidy -o hpc_ai.html
scp hpc_ai.html ubuntu@training-slides.cloud.cvl.org.au:/opt/training_slides/slides/index.html
scp util.png ubuntu@training-slides.cloud.cvl.org.au:/opt/training_slides/slides/
