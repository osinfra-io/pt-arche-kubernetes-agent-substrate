# Kubernetes Agent Substrate OpenTofu Module

[![OpenTofu Tests](https://img.shields.io/github/actions/workflow/status/osinfra-io/pt-arche-kubernetes-agent-substrate/test.yml?style=for-the-badge&logo=opentofu&color=FEDA15&label=OpenTofu%20Tests)](https://github.com/osinfra-io/pt-arche-kubernetes-agent-substrate/actions/workflows/test.yml) [![Dependabot](https://img.shields.io/github/actions/workflow/status/osinfra-io/pt-arche-kubernetes-agent-substrate/dependabot.yml?style=for-the-badge&logo=github&color=2088FF&label=Dependabot)](https://github.com/osinfra-io/pt-arche-kubernetes-agent-substrate/actions/workflows/dependabot.yml) [![Datadog Security Enabled](https://img.shields.io/badge/Datadog%20Security-Enabled-632CA6?style=for-the-badge&logo=datadog)](https://app.datadoghq.com/security/code-security/repositories?repository_id=pt-arche-kubernetes-agent-substrate)

## Repository Description

Reusable OpenTofu child module that installs the Agent Substrate CRDs and control plane (`substrate-crds` and `substrate` Helm charts) on GKE. [kagent](https://github.com/osinfra-io/pt-arche-kubernetes-kagent) uses it to run agents in sandboxed actors.

## 🔩 Usage

Create the namespace in the consuming root and pass its name explicitly. Deploy this module before `pt-arche-kubernetes-kagent`; its `api_endpoint` output is the endpoint kagent connects to.

Like the authentik module, this module uses external PostgreSQL and existing Secrets: `postgres_owner_secret_name` and `postgres_read_write_secret_name` name Secrets whose `ownerConnectionString` and `readWriteConnectionString` keys hold the connection strings. The chart does not provision the rest of its prerequisites: the cluster needs the `ClusterTrustBundle`, `ClusterTrustBundleProjection`, and `PodCertificateRequest` feature gates with the `certificates.k8s.io/v1beta1` API, and the substrate-podcert certificate controller. See the [chart README](https://github.com/agent-substrate/substrate/tree/main/charts/substrate).

The chart exposes no pod label values, so Datadog unified service tagging labels are not applied to Agent Substrate pods.

> [!TIP]
> You can check the [tests/fixtures](tests/fixtures) directory for example configurations. These fixtures set up the system for testing by providing all the necessary initial code, thus creating good examples on which to base your configurations.

## 🛠️ Tools

- [Helm](https://github.com/helm/helm)
- [osinfra-pre-commit-hooks](https://github.com/osinfra-io/pt-techne-pre-commit-hooks)
- [pre-commit](https://github.com/pre-commit/pre-commit)

## 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [Agent Substrate](https://github.com/agent-substrate/substrate)
- [kagent Agent Substrate guide](https://kagent.dev/docs/kagent/latest/)

## 🔍 Tests

All OpenTofu tests are [mocked](https://opentofu.org/docs/cli/commands/test/#the-mock_provider-blocks) allowing us to test the module without creating infrastructure or requiring credentials. The trade-offs are acceptable in favor of speed and simplicity. In an OpenTofu test, a mocked provider or resource will generate fake data for all computed attributes that would normally be provided by the underlying provider APIs.

```none
tofu init
tofu test
```

## 📦 Release

Push a semantic version tag after tests pass:

```none
git tag vX.Y.Z
git push origin vX.Y.Z
```
