Slurm script template and solutions (in [OBDS-Training/OBDS_Syllabus](https://github.com/OBDS-Training/OBDS_Syllabus) GitHub repository) are based on [Kevin's template](https://github.com/kevinrue/OBDS_scripts/blob/main/slurm_template_short.sh)

### 2023 Sep - Liezel

- Schedule 
  + Took over whole PM (after lunch) session of Day 3, AM session is Conda/Mamba last half then Read QC
  + Had to discuss solution script the next day so just need to a bit aware of time but half day should be fine
   
### 2024 Jan - Liezel

Lesson
- [x] Emphasise that the commands in slurm template script can be removed for the exercises, saw many not deleting those demo commands
- [x] Make sure not to put solutions in same directory as template because although they can't read the solutions, they can still see they exist because they read
permissions on directory to view the template, this confused them last round
  + Instead of deleting, solutions are in the directory as tarball
- [x] Modify template to have sleep so it will stay on queue
- [x] Emphasise what are comments on template, what are slurm options and what are commands
- [x] Provide an simplified template without a lot of comments?
  + Just emphasise which lines are comments
