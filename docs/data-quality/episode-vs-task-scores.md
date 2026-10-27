# Episode Totals vs. Task Scores

## Table of Contents

- [Observation](#observation)
- [Interpretation](#interpretation)
- [Modeling Implications](#modeling-implications)
- [Potential Next Step](#potential-next-step)

## Observation

The sum of raw task scores does not always match the episode totals recorded in the source data.

The observed difference is consistent with episode totals including final scores, such as bonus points, that are not attributed to individual tasks in the task-score data.

## Interpretation

The two values represent different measures:

- **Task-score sum:** The sum of scores recorded against individual tasks.
- **Episode total:** The final score recorded for an episode, potentially including points awarded outside individual tasks.

A mismatch between these measures is not, by itself, evidence of an error. The measures need to be interpreted according to their respective definitions.

## Modeling Implications

Keep the task-score fact table at its intended task-level grain. Do not add episode totals to individual task rows, because doing so would mix measures at different grains and could lead to double counting.

If episode-level final scores are needed for analysis, model them separately from task-level scores and document their source and definition.

## Potential Next Step

Consider a separate `fct_episode_score` model if episode-level totals are reliable and useful for planned analyses. Before implementing it, verify the source fields and define the expected grain and relationships to episodes and contestants.