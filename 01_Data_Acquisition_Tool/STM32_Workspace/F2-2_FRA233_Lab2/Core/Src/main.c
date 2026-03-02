/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file           : main.c
 * @brief          : Main program body
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2026 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include <math.h>
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
TIM_HandleTypeDef htim3;

/* USER CODE BEGIN PV */
int Start_State = 0;
int Last_State = 0;

float W_n = 0.0, W_n1 = 0.0, W_n2 = 0.0; // Current and Past of W
float V_n = 0.0, V_n1 = 0.0, V_n2 = 0.0; // Current and Past of V
float c_Wn = 0.0, c_W1 = 0.0, c_W2 = 0.0, c_Vn = 0.0, c_V1 = 0.0, c_V2 = 0.0; // Coefficient

float R = 3.57f;
float L = 0.003313f;
float Bm = 0.00000214f;
float Jm = 0.000011739f;
float km = 0.049575f;
float ke = 0.050668f;
float Ts = 0.001f;

float t = 0.0f;
float freq_sine = 1.0f;
float amp_sine = 12.0f;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_TIM3_Init(void);
/* USER CODE BEGIN PFP */
void Init_Discrete_Model_ForwardDiscrete();
void Init_Discrete_Model_BackwardDiscrete();
void Init_Discrete_Model_TrapezoidalDiscrete();
/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{

  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_TIM3_Init();
  /* USER CODE BEGIN 2 */
  Init_Discrete_Model_ForwardDiscrete();
	HAL_TIM_Base_Start_IT(&htim3);
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
	while (1) {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
		if (Start_State == 1 && Last_State == 0) {
			t = 0.0f;
			__HAL_TIM_SET_COUNTER(&htim3, 0);
			HAL_TIM_Base_Start_IT(&htim3);
			Last_State = 1;
		}

		else if (Start_State == 0 && Last_State == 1) {
			HAL_TIM_Base_Stop_IT(&htim3);
			t = 0.0f;
			V_n = 0.0f;
			W_n = 0.0f;
			Last_State = 0;
		}
	}
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Configure the main internal regulator output voltage
  */
  HAL_PWREx_ControlVoltageScaling(PWR_REGULATOR_VOLTAGE_SCALE1_BOOST);

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLM = RCC_PLLM_DIV6;
  RCC_OscInitStruct.PLL.PLLN = 85;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = RCC_PLLQ_DIV2;
  RCC_OscInitStruct.PLL.PLLR = RCC_PLLR_DIV2;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_4) != HAL_OK)
  {
    Error_Handler();
  }
}

/**
  * @brief TIM3 Initialization Function
  * @param None
  * @retval None
  */
static void MX_TIM3_Init(void)
{

  /* USER CODE BEGIN TIM3_Init 0 */

  /* USER CODE END TIM3_Init 0 */

  TIM_ClockConfigTypeDef sClockSourceConfig = {0};
  TIM_MasterConfigTypeDef sMasterConfig = {0};

  /* USER CODE BEGIN TIM3_Init 1 */

  /* USER CODE END TIM3_Init 1 */
  htim3.Instance = TIM3;
  htim3.Init.Prescaler = 16999;
  htim3.Init.CounterMode = TIM_COUNTERMODE_UP;
  htim3.Init.Period = 9;
  htim3.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
  htim3.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
  if (HAL_TIM_Base_Init(&htim3) != HAL_OK)
  {
    Error_Handler();
  }
  sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
  if (HAL_TIM_ConfigClockSource(&htim3, &sClockSourceConfig) != HAL_OK)
  {
    Error_Handler();
  }
  sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  if (HAL_TIMEx_MasterConfigSynchronization(&htim3, &sMasterConfig) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN TIM3_Init 2 */

  /* USER CODE END TIM3_Init 2 */

}

/**
  * @brief GPIO Initialization Function
  * @param None
  * @retval None
  */
static void MX_GPIO_Init(void)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};
  /* USER CODE BEGIN MX_GPIO_Init_1 */

  /* USER CODE END MX_GPIO_Init_1 */

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOC_CLK_ENABLE();
  __HAL_RCC_GPIOF_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(LD2_GPIO_Port, LD2_Pin, GPIO_PIN_RESET);

  /*Configure GPIO pin : B1_Pin */
  GPIO_InitStruct.Pin = B1_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_IT_RISING;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  HAL_GPIO_Init(B1_GPIO_Port, &GPIO_InitStruct);

  /*Configure GPIO pins : LPUART1_TX_Pin LPUART1_RX_Pin */
  GPIO_InitStruct.Pin = LPUART1_TX_Pin|LPUART1_RX_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  GPIO_InitStruct.Alternate = GPIO_AF12_LPUART1;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /*Configure GPIO pin : LD2_Pin */
  GPIO_InitStruct.Pin = LD2_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(LD2_GPIO_Port, &GPIO_InitStruct);

  /* EXTI interrupt init*/
  HAL_NVIC_SetPriority(EXTI15_10_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(EXTI15_10_IRQn);

  /* USER CODE BEGIN MX_GPIO_Init_2 */

  /* USER CODE END MX_GPIO_Init_2 */
}

/* USER CODE BEGIN 4 */
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim) {
	if (htim == &htim3) {
		if (Start_State == 1) {
			t += Ts;

			// Generate SineWave ----
//			if (t >= (1.0f / freq_sine)) {
//				t -= (1.0f / freq_sine);
//			}
			V_n = amp_sine * sinf(2.0f * 3.1415926f * freq_sine * t);
			// ----------------------

			//	float slope = 1.0f;
			//	float delay_time = 1.0f;
			//	if (t >= delay_time) {
			//		V_n = slope * (t - 0.999);
			//	} else {
			//		V_n = 0;
			//	}

			if (V_n > 12.0f) {
				V_n = 12.0f;
			} else if (V_n < -12.0f) {
				V_n = -12.0f;
			}

			// Memory Past State and Calculate Wn
			float Cal_Wn = (c_W1 * W_n1) + (c_W2 * W_n2) + (c_Vn * V_n)
					+ (c_V1 * V_n1) + (c_V2 * V_n2);

			if (Cal_Wn >= 237) {
				W_n = 237;
			} else if (Cal_Wn <= -237) {
				W_n = -237;
			} else {
				W_n = Cal_Wn;
			}

			W_n2 = W_n1;
			W_n1 = W_n;
			V_n2 = V_n1;
			V_n1 = V_n;
		} else {
			t = 0.0f;
			V_n = 0.0f;
			W_n = 0.0f;
		}

	}
}

void Init_Discrete_Model_ForwardDiscrete() {
	c_Wn = 0.0f;
	c_Vn = 0.0f;
	c_V1 = 0.0f;

	float den = Jm * L;
	c_W1 = ((2 * Jm * L) - (Bm * L * Ts) - (Jm * R * Ts)) / den;
	c_W2 = ((-Jm * L) + (Bm * L * Ts) + (Jm * R * Ts) - (Ts * Ts * R * Bm)
			- (Ts * Ts * km * ke)) / den;
	c_V2 = (km * Ts * Ts) / den;
}

void Init_Discrete_Model_BackwardDiscrete() {
	c_Wn = 0.0f;
	c_V1 = 0.0f;
	c_V2 = 0.0f;

	float den = (Jm * L) + (Bm * L * Ts) + (R * Jm * Ts) + (Ts * Ts * R * Bm)
			+ (km * ke * Ts * Ts);
	c_W1 = ((2.0f * Jm * L) + (Bm * L * Ts) + (R * Jm * Ts)) / den;
	c_W2 = ((-1.0f * Jm * L)) / den;
	c_Vn = ((km * Ts * Ts)) / den;
}

void Init_Discrete_Model_TrapezoidalDiscrete() {
	c_Wn = 0.0f;

	float a = Jm * L;
	float b = (Bm * L) + (R * Jm);
	float c = (R * Bm) + (km * ke);
	float d = km;
	float k = 2.0f / Ts;

	float den = (a * k * k) + (b * k) + c;

	c_W1 = ((2.0f * a * k * k) - (2.0f * c)) / den;
	c_W2 = -((a * k * k) - (b * k) + c) / den;
	c_Vn = d / den;
	c_V1 = (2.0f * d) / den;
	c_V2 = d / den;
}
/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
	/* User can add his own implementation to report the HAL error return state */
	__disable_irq();
	while (1) {
	}
  /* USER CODE END Error_Handler_Debug */
}
#ifdef USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */
