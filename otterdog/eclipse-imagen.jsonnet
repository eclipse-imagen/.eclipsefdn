local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('technology.imagen', 'eclipse-imagen') {
  settings+: {
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  secrets+: [
    orgs.newOrgSecret('GPG_KEY_ID') {
      value: "pass:bots/technology.imagen/gpg/key_id",
    },
    orgs.newOrgSecret('GPG_PASSPHRASE') {
      value: "pass:bots/technology.imagen/gpg/passphrase",
    },
    orgs.newOrgSecret('GPG_PRIVATE_KEY') {
      value: "pass:bots/technology.imagen/gpg/secret-subkeys.asc",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_PASSWORD') {
      value: "pass:bots/technology.imagen/central.sonatype.org/token-password",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_USERNAME') {
      value: "pass:bots/technology.imagen/central.sonatype.org/token-username",
    },
  ],
  _repositories+:: [
    orgs.newRepo('imagen') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "main",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/docs",
      homepage: "",
      web_commit_signoff_required: false,
      environments: [
        orgs.newEnvironment('github-pages') {
          deployment_branch_policy: "selected",
          branch_policies: [
            "main",
          ]
        },
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}
