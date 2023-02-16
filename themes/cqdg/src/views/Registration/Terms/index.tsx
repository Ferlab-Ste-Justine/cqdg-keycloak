import { ArrowRightOutlined, InfoCircleOutlined } from "@ant-design/icons";
import ScrollContent from "@ferlab/ui/core/layout/ScrollContent";
import GridCard from "@ferlab/ui/core/view/v2/GridCard";
import { Button, Checkbox, Form, Space, Tooltip, Typography } from "antd";
import { useKcMessage } from "keycloakify";
import { useDispatch } from "react-redux";
import { useRegistrationFlow } from "store/registrationFlow";
import { registrationFlowActions } from "store/registrationFlow/slice";
import { TUser } from "store/registrationFlow/types";
import { KcContext_LoginUpdateProfile } from "..";

import styles from "./index.module.scss";

const LAST_UPDATED_DATE = "2023-02-16";

enum FORM_FIELDS {
  CHECKBOXES = "checkboxes",
}

enum CHECKBOXES_OPTIONS {
  ACCEPTED_TERMS = "accepted_terms",
  UNDERSTAND_DISCLAIMER = "understand_disclaimer",
}

const { Title, Text } = Typography;

const TermsStep = ({
  kcContext,
}: {
  kcContext: KcContext_LoginUpdateProfile;
}) => {
  const { redirectUrl } = kcContext;

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { userInfo } = useRegistrationFlow();

  const { advancedMsg } = useKcMessage();

  const getInitialValues = (localUser: TUser) => {
    let value = [];
    if (localUser?.accepted_terms || kcContext.userProfile.accepted_terms) {
      value.push(CHECKBOXES_OPTIONS.ACCEPTED_TERMS);
    }
    if (
      localUser?.understand_disclaimer ||
      kcContext.userProfile.understand_disclaimer
    ) {
      value.push(CHECKBOXES_OPTIONS.UNDERSTAND_DISCLAIMER);
    }
    return value;
  };
  return (
    <Space
      direction="vertical"
      size={24}
      className={styles.termsAndConditionsWrapper}
    >
      <Title level={3} className={styles.mainTitle}>
        {advancedMsg("registration_title")}
      </Title>
      <Text>
        {advancedMsg("portal_introduction")}
      </Text>
      <GridCard
        wrapperClassName={styles.cardWrapper}
        className={styles.card}
        title={
          <div className={styles.termsCardHeader}>
            <span className={styles.title}>
              {advancedMsg("terms_title")}
            </span>
            <span className={styles.lastUpdateDate}>
              {LAST_UPDATED_DATE}
              <Tooltip arrowPointAtCenter placement="top" title={advancedMsg("last_update_tooltip")} className={styles.tooltipGold}>
                <InfoCircleOutlined className={styles.tooltipIcon} />
              </Tooltip>
            </span>
          </div>
        }
        content={
          <ScrollContent className={styles.termsListWrapper}>
            <ol className={styles.termsList}>
              <li>{advancedMsg("terms_1")}</li>
              <li>{advancedMsg("terms_2")}</li>
              <li>{advancedMsg("terms_3")}</li>
              <li>{advancedMsg("terms_4")}</li>
              <li>{advancedMsg("terms_5")}</li>
              <li>{advancedMsg("terms_6")}</li>
              <li>{advancedMsg("terms_7")}</li>
            </ol>
          </ScrollContent>
        }
      />
      <GridCard
        wrapperClassName={styles.cardWrapper}
        className={styles.card}
        title={advancedMsg("disclaimer_title")}
        content={
          <ul className={styles.termsList}>
            <li>{advancedMsg("disclaimer_1")}</li>
            <li>{advancedMsg("disclaimer_2")}</li>
            <li>{advancedMsg("disclaimer_3")}</li>
          </ul>
        }
      />
      <Form
        form={form}
        className={styles.checkboxForm}
        onFinish={() => {
          dispatch(registrationFlowActions.acceptTerms());
          dispatch(registrationFlowActions.nextStep());
        }}
        fields={[
          {
            name: [FORM_FIELDS.CHECKBOXES],
            value: getInitialValues(userInfo!),
          },
        ]}
      >
        <Form.Item
          className={styles.checkboxItem}
          name={FORM_FIELDS.CHECKBOXES}
          rules={[
            {
              validator: async (rule, value: string[]) => {
                return value?.length === 2
                  ? Promise.resolve()
                  : Promise.reject(
                      advancedMsg("terms_disclaimer_error")
                    );
              },
              validateTrigger: "onSubmit",
            },
          ]}
        >
          <Checkbox.Group>
            <Space direction="vertical">
              <Checkbox value={CHECKBOXES_OPTIONS.ACCEPTED_TERMS}>
                {advancedMsg("terms_checkbox")}
              </Checkbox>
              <Checkbox value={CHECKBOXES_OPTIONS.UNDERSTAND_DISCLAIMER}>
              {advancedMsg("disclaimer_checkbox")}
              </Checkbox>
            </Space>
          </Checkbox.Group>
        </Form.Item>
      </Form>
      <Space className={styles.checkboxFormFooter}>
        <Button onClick={() =>  window.location.href=redirectUrl}>{advancedMsg("cancel")}</Button>
        <Button
          type="primary"
          className="iconRight"
          onClick={() => form.submit()}
        >
          {advancedMsg("next")} <ArrowRightOutlined />
        </Button>
      </Space>
    </Space>
  );
};

export default TermsStep;
