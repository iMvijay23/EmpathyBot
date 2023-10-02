#!/bin/bash

# Activate conda environment
conda env list
conda activate llmtrain

# Install Python dependencies
#pip install -r requirements.txt

# Restrict to GPU 0
#export CUDA_VISIBLE_DEVICES=0

# Set W&B and HuggingFace API keys
export WANDB_API_KEY='my key'
export HUGGINGFACE_TOKEN='my key'

# Running the training script
accelerate launch --config_file "configs/deepspeed_config.yaml"  train.py \
--model_name "meta-llama/Llama-2-7b-chat-hf" \
--dataset_name "vtiyyal1/AskDocs-53k" \
--max_seq_len 2048 \
--num_train_epochs 2 \
--max_steps 50000 \
--logging_steps 25 \
--eval_steps 100 \
--save_steps 500 \
--bf16 True \
--packing True \
--output_dir "/data/solr/models/askdocsproject" \
--per_device_train_batch_size 1 \
--gradient_accumulation_steps 2 \
--dataset_text_field "content" \
--use_gradient_checkpointing \
--use_peft_lora True \
--use_8bit_qunatization False \
--learning_rate 5e-5  \
--lr_scheduler_type "cosine" \
--weight_decay 0.01 \
--warmup_ratio 0.03 \
--use_flash_attn True
