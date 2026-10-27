# Branch workflow

The mainline/default branch is named `master`, not `main`. Make shared changes in a pull request targeting `master` first, then port them consistently to `with-mongoid` and `with-activerecord`.

All three branches are actively maintained. Keep shared code, examples, documentation, and CI aligned, with minimal branch-specific differences:

- `master`: ActiveModel examples with generated data and no persistence.
- `with-mongoid`: MongoDB persistence, string IDs, and cursor/size pagination.
- `with-activerecord`: PostgreSQL persistence, integer IDs, and page/size pagination.

Review and merge the mainline change before its branch-specific ports. Preserve each branch's intended behavior and validate the port against its database and supported compatibility matrix. Keep purely branch-specific fixes on the affected branch; do not introduce database dependencies into `master` or merge entire branches just to port a shared change.
