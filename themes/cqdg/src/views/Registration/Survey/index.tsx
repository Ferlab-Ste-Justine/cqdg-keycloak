import { ArrowLeftOutlined } from "@ant-design/icons";
import { Button, Checkbox, Form, Input, Space, Typography } from "antd";
import cx from "classnames";
import { useDispatch } from "react-redux";
import { useKcMessage } from "keycloakify";
import { registrationFlowActions } from "store/registrationFlow/slice";
import { userLogin } from "store/registrationFlow/thunks";
import { KcContext_LoginUpdateProfile } from "..";

import styles from "./index.module.scss";

enum FORM_FIELDS {
  ROLES = "roles",
  AFFILIATION = "affiliation",
  NO_AFFILIATION = "no_affiliation",
  RESEARCH_AREAS = "reasearch_areas",
}

const { Text } = Typography;

const OTHER_KEY = 'other';
const NOT_APPLICABLE_KEY = 'not_applicable';

const roleMessagePrefix = "survey_form_role_";
const roleOptions = [
  "researcher",
  "clinician",
  "representative",
  "bioinformatician",
  "governmental_employee",
];

const researchAreaMessagePrefix = "survey_form_research_area_";
const researchAreaOptions = [
  "aging",
  "bioinformatics",
  "birth_defects",
  "cancer",
  "circulatory_repiratory_health",
  "general_health",
  "infection_immunity",
  "musculoskeletal_health_arthritis",
  "neurodevelopmental_conditions",
  "neurosciences_mental_health_addiction",
  "nutrition_metabolism_diabetes",
  "population_genomics",
  "rare_diseases",
];
const SurveyStep = ({
  kcContext,
}: {
  kcContext: KcContext_LoginUpdateProfile;
}) => {
  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { redirectUrl } = kcContext;

  const { advancedMsg, advancedMsgStr } = useKcMessage();

  const researchAreaSortFunction = (area1: string, area2: string) => advancedMsgStr(researchAreaMessagePrefix + area1).localeCompare(advancedMsgStr(researchAreaMessagePrefix + area2));

  const validateMessages = {
    required: advancedMsgStr('required_field_error'),
  };

  return (
    <Form
      form={form}
      className={styles.registrationForm}
      fields={[
        {
          name: [FORM_FIELDS.ROLES],
          value: kcContext.userProfile.roles,
        },
        {
          name: [FORM_FIELDS.AFFILIATION],
          value: kcContext.userProfile.affiliation,
        },
        {
          name: [FORM_FIELDS.NO_AFFILIATION],
          value: kcContext.userProfile.affiliation ? false : undefined,
        },
        {
          name: [FORM_FIELDS.RESEARCH_AREAS],
          value: kcContext.userProfile.research_areas,
        },
      ]}
      onFinish={(values) => {
        dispatch(
          userLogin({
            url: kcContext.url.loginAction,
            redirectUrl: kcContext.redirectUrl,
            userInfo: {
              first_name: kcContext.userProfile.first_name,
              last_name: kcContext.userProfile.last_name,
              roles: values[FORM_FIELDS.ROLES],
              affiliation: values[FORM_FIELDS.AFFILIATION],
              research_areas: values[FORM_FIELDS.RESEARCH_AREAS],
            },
          })
        );
      }}
      layout="vertical"
      validateMessages={validateMessages}
    >
      <Text className={styles.allFieldRequiredNotice}>
        {advancedMsg("survey_introduction")}
      </Text>
      <Form.Item
        className={styles.withCustomHelp}
        name={FORM_FIELDS.ROLES}
        label={advancedMsg("survey_form_roles_label")}
        required={false}
        rules={[{ required: true }]}
      >
        <Checkbox.Group className={styles.checkBoxGroup}>
          <span className={styles.help}>{advancedMsg("checkbox_help")}</span>
          <Space direction="vertical">
            {roleOptions.map((option, index) => (
              <Checkbox key={index} value={option}>
                {advancedMsg(roleMessagePrefix + option)}
              </Checkbox>
            ))}
            <Checkbox value={OTHER_KEY}>{advancedMsg(roleMessagePrefix + OTHER_KEY)}</Checkbox>
          </Space>
        </Checkbox.Group>
      </Form.Item>
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues[FORM_FIELDS.NO_AFFILIATION] !==
          currentValues[FORM_FIELDS.NO_AFFILIATION]
        }
      >
        {({ getFieldValue }) =>
          !getFieldValue(FORM_FIELDS.NO_AFFILIATION) ? (
            <Form.Item
              className={cx(styles.withCustomHelp, styles.affiliationField)}
              label={advancedMsg("survey_form_affiliation_label")}
            >
              <span className={styles.help}>
                {advancedMsg("survey_form_affiliation_help")}
              </span>
              <Form.Item
                name={FORM_FIELDS.AFFILIATION}
                className={styles.noMargin}
                required={false}
                rules={[{ required: true }]}
              >
                <Input />
              </Form.Item>
            </Form.Item>
          ) : null
        }
      </Form.Item>
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues[FORM_FIELDS.NO_AFFILIATION] !==
          currentValues[FORM_FIELDS.NO_AFFILIATION]
        }
      >
        {() => (
          <Form.Item
            name={FORM_FIELDS.NO_AFFILIATION}
            label={
              form.getFieldValue(FORM_FIELDS.NO_AFFILIATION)
                ? advancedMsg("survey_form_affiliation_label")
                : ""
            }
            className={cx(
              styles.withCustomHelp,
              form.getFieldValue(FORM_FIELDS.NO_AFFILIATION) &&
                styles.noAffiliationField
            )}
            rules={[{ required: false }]}
            valuePropName="checked"
          >
            <Checkbox>{advancedMsg("survey_form_no_affiliation_label")}</Checkbox>
          </Form.Item>
        )}
      </Form.Item>
      <Form.Item
        className={styles.withCustomHelp}
        name={FORM_FIELDS.RESEARCH_AREAS}
        label={advancedMsg("survey_form_research_areas_label")}
        required={false}
        rules={[{ required: true }]}
      >
        <Checkbox.Group className={styles.checkBoxGroup}>
          <span className={styles.help}>{advancedMsg("checkbox_help")}</span>
          <Space direction="vertical">
            {researchAreaOptions.sort(researchAreaSortFunction).map((option, index) => (
              <Checkbox key={index} value={option}>
                {advancedMsg(researchAreaMessagePrefix + option)}
              </Checkbox>
            ))}
            <Checkbox value={NOT_APPLICABLE_KEY}>{advancedMsg(researchAreaMessagePrefix + NOT_APPLICABLE_KEY)}</Checkbox>
            <Checkbox value={OTHER_KEY}>{advancedMsg(researchAreaMessagePrefix + OTHER_KEY)}</Checkbox>
          </Space>
        </Checkbox.Group>
      </Form.Item>
      <Space className={styles.registrationFooter}>
        <Button
          icon={<ArrowLeftOutlined />}
          onClick={() => dispatch(registrationFlowActions.previousStep())}
        >
          {advancedMsg("back")}
        </Button>
        <Space>
          <Button onClick={() =>  window.location.href=redirectUrl}>{advancedMsg("cancel")}</Button>
          <Button type="primary" htmlType="submit">
            {advancedMsg("submit")}
          </Button>
        </Space>
      </Space>
    </Form>
  );
};

export default SurveyStep;
