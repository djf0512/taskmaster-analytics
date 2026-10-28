# Episode Totals vs. Task Scores

## Finding

The episodes file holds the official points per contestant per episode, as printed in the broadcast tables, in seat order. They are not computed from the task scores, so they can differ from the sum of a contestant's task points.

Across the 935 contestant-episodes in the included series (task points exclude tiebreak tasks):

| Difference (official minus task sum) | Contestant-episodes |
|---|---|
| 0 | 715 (76%) |
| Positive (+1 to +12) | 216 |
| Negative (-4 to -1) | 4 |

That three quarters match exactly supports the counting rule (all tasks count except tiebreaks). Positive differences are consistent with bonus points awarded outside tasks, and negative ones with deductions.

The four negative rows:

| Series | Episode | Contestant | Difference |
|---|---|---|---|
| Series 4 | 3 | Mel Giedroyc | -4 |
| Series 9 | 8 | Rose Matafeo | -1 |
| Series 11 | 1 | Sarah Kendall | -1 |
| Series 18 | 7 | Rosie Jones | -3 |

The four negative rows correspond to points deduction awarded in the episodes themselves, so the official totals are lower than the sum of task scores.

## Decision

- Task points stay at task grain in `fct_task_points`.
- Official points come from the episodes file (`int_episode_contestant_points`) and are stored in `fct_episode_points` next to the task sum.
- The difference is `episode_adjustment_points`. Series points use the official totals, so series winners follow the broadcast results.
- `assert_task_points_reconcile_across_facts` checks that task points add up identically at task, episode, and series grain.

## Reproduce

```sql
select episode_adjustment_points, count(*) from marts.fct_episode_points group by 1 order by 1;
```
