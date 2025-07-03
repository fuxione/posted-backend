### 🚅 Posted Backend 💨

```bash
rails rails db:migrate:reset && bundle exec annotaterb models && bundle exec erd
rails s
```

- how do you make migration more readable? gem for formatting? prettier?
- understand click model more
- how do you organize enums? for models validation?

- add validations
- add seeds
- add buyers_stack resolver (initial -> final [post inclusion/exclusion])
  - create a stack_result ( w? no log_if for all the disabled/excluded buyers)
  - add buyers stats as they are completed (winner, error, timeout)

```
0s                                                        60s
<-----------------------------------------------------------> STACK ->
[------------- 1 -------------]
|_[b1] ------* 
|_[b2] ---*
|_[b5] ------------------------x
                                [------------- 2 -------------]
                                |_[b7]

```
- lead_buyers_stack job - timeout? 2mins
  - stack_job_1 [group]
    - buyer_job_1 - timeout? 30sec
    - buyer_job_2
  - stack_job_2 [solo]
  - ...

- integrate providers
  - apollo
  - spoinwheel

- integrate buyesrs
  - epcvip
  - even financial
  - ...